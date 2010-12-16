//
//  CWNSObjectAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/15/10.
//  Copyright 2010. All rights reserved.
//

#import "NSObjectAdditions.h"


@implementation NSObject (CWNSObjectAdditions)

/**
 returns the value associated with a key
 */
-(id)cw_valueAssociatedWithKey:(void *)key
{
	return objc_getAssociatedObject(self, key);
}

/**
 Associates the value with a key using a strong reference
 */
-(void)cw_associateValue:(id)value withKey:(void *)key
{
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

/**
 Associates the value with a key using a weak reference
 */
-(void)cw_associateWeakValue:(id)value withKey:(void *)key
{
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

/**
 Associates the value with a key using the specified 
 objective-c association policy
 */
-(void)cw_associateValue:(id)value
				 withKey:(void *)key
  usingAssociationPolicy:(objc_AssociationPolicy)policy
{
	objc_setAssociatedObject(self, key, value, policy);
}

@end
