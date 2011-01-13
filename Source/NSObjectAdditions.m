//
//  CWNSObjectAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/15/10.
//  Copyright 2010. All rights reserved.
//

#import "NSObjectAdditions.h"
#import <objc/runtime.h>

@implementation NSObject (CWNSObjectAdditions)

#pragma mark -
#pragma mark Objective-C Associated Objects

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

#pragma mark -
#pragma mark Exerimental Perform with Block Methods

-(void)cw_performAfterDelay:(dispatch_time_t)delay withBlock:(ObjTimeBlock)block
{
	[self cw_performAfterDelay:delay onQueue:dispatch_get_main_queue() withBlock:block];
}

-(void)cw_performAfterDelay:(dispatch_time_t)delay onQueue:(dispatch_queue_t)queue withBlock:(ObjTimeBlock)block
{
	dispatch_after(delay, queue, block);
}

@end
