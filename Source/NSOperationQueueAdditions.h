//
//  NSOperationQueueAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 9/30/11.
//  Copyright 2012. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSOperationQueue (NSOperationQueueAdditions)

/**
 adds the block to the operation queue after a delay in seconds
 
 @param a double time in seconds to wait before enqueueing the block
 @param block the block to be executed
 */
-(void)cw_addOperationAfterDelay:(double)delay withBlock:(dispatch_block_t)block;

@end
