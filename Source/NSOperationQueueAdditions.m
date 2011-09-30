//
//  NSOperationQueueAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 9/30/11.
//  Copyright 2011. All rights reserved.
//

#import "NSOperationQueueAdditions.h"

@implementation NSOperationQueue (NSOperationQueueAdditions)

/**
 adds the block to the operation queue after a delay in seconds
 
 @param a double representing time in seconds for the block to be delayed adding onto a NSOperationQueue
 */
-(void)cw_addOperationAfterDelay:(double)delay 
                       withBlock:(void (^)(void))block {
    NSParameterAssert(block);
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self addOperationWithBlock:block];
    });
}

@end
