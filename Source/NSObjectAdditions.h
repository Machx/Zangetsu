//
//  CWNSObjectAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/15/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface   NSObject (CWNSObjectAdditions) {}

-(id)cw_valueAssociatedWithKey:(void *)key;

-(void)cw_associateValue:(id)value withKey:(void *)key;

-(void)cw_associateWeakValue:(id)value withKey:(void *)key;

/**
 temporarily removing this api for now as in including <objc/runtime.h> it caused
 _error to be unavailable as a variable name. By moving it to the .m file this is better
 design anyway. I will try and revisit this in the future and remove this or fix this api.
 the associateValue or associateWeakValue api's are better for general use anyway.
 */
//-(void)cw_associateValue:(id)value withKey:(void *)key usingAssociationPolicy:(objc_AssociationPolicy)policy;

@end
