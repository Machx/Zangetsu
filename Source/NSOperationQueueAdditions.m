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
 @param block the block to be executed on the queue after a delay
 */
-(void)cw_addOperationAfterDelay:(double)delay 
                       withBlock:(dispatch_block_t)block 
{
    NSParameterAssert(block);
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW,(delay * NSEC_PER_SEC));
	dispatch_queue_t queue = dispatch_queue_create("com.Zangetsu.NSOperationQueueAdditions", 0);
    dispatch_after(popTime, queue, ^(void){
        [self addOperationWithBlock:block];
    });
	dispatch_release(queue);
}

@end
