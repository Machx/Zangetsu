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

// Block Timing Methods

-(void)cw_performAfterDelay:(NSTimeInterval)delay withBlock:(void (^)())block;

// Queueing  Methods

-(void)cw_performSelector:(SEL)selector withObject:(id)obj onQueue:(NSOperationQueue *)queue;

-(void)cw_performSelector:(SEL)selector withObject:(id)obj onGCDQueue:(dispatch_queue_t)queue;

// Objective-C Class lookup methods

-(NSArray *)cw_directSubclasses;

// Objective-C Method Swizzling

-(BOOL)cw_swizzleMethod:(SEL)originalSel withNewMethod:(SEL)newSel error:(NSError **)error;

+(BOOL)cw_swizzleClassMethod:(SEL)originalSel withNewMethod:(SEL)newSel error:(NSError **)error;

@end
