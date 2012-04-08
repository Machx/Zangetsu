//
//  NSOperationQueueAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 9/30/11.
//  Copyright 2011. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSOperationQueue (NSOperationQueueAdditions)

-(void)cw_addOperationAfterDelay:(double)delay withBlock:(dispatch_block_t)block;

@end
