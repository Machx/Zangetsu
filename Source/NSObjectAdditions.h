//
//  CWNSObjectAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/15/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface   NSObject (CWNSObjectAdditions) {}

// Objective-C Associated Objects

-(id)cw_valueAssociatedWithKey:(void *)key;

-(void)cw_associateValue:(id)value withKey:(void *)key;

-(void)cw_associateWeakValue:(id)value withKey:(void *)key;

// Block Timing Functions

typedef void (^ObjTimeBlock)(void);

-(void)cw_performAfterDelay:(NSTimeInterval)delay withBlock:(ObjTimeBlock)block;

@end
