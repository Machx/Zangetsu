/*
//  CWSerialBlockQueue.m
//  Zangetsu
//
//  Created by Colin Wheeler on 2/23/12.
//  Copyright (c) 2012. All rights reserved.
//
 
 Copyright (c) 2011 Colin Wheeler
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "CWSerialBlockQueue.h"

@interface CWSerialBlockOperation()
@property(nonatomic,copy) dispatch_block_t operationBlock;
@end

@implementation CWSerialBlockOperation

@synthesize operationBlock = _operationBlock;
@synthesize completionBlock = _completionBlock;

- (id)init
{
    self = [super init];
    if (self) {
        _operationBlock = NULL;
		_completionBlock = NULL;
    }
    return self;
}

/**
 Returns a new CWSerialBlockOperation object that executes block when it is dequeued
 
 @param block a dispatch_block_t block that must not be NULL
 @return a new CWSerialBlockOperation object
 */
+(CWSerialBlockOperation *)blockOperationWithBlock:(dispatch_block_t)block
{
	CWSerialBlockOperation *operation = [[CWSerialBlockOperation alloc] init];
	operation.operationBlock = block;
	return operation;
}

@end

@interface CWSerialBlockQueue()
@property(nonatomic, assign) dispatch_queue_t queue;
@property(atomic,retain) CWQueue *blocksQueue;
@property(readwrite,retain) NSString *label;
@end

@implementation CWSerialBlockQueue

@synthesize blocksQueue = _blocksQueue;
@synthesize queue = _queue;
@synthesize label = _label;

/**
 Returns a new CWSerialBlockQueue initialized with a unique label
 
 @return a new CWSerialBlockQueue object
 */
- (id)init
{
    self = [super init];
    if (self) {
        _blocksQueue = [[CWQueue alloc] init];
		NSString *qLabel = CWUUIDStringPrependedWithString(@"com.Zangetsu.CWSerialBlockQueue-");
		_queue = dispatch_queue_create([qLabel UTF8String], DISPATCH_QUEUE_SERIAL);
		_label = qLabel;
    }
    return self;
}

-(id)initWithLabel:(NSString *)qLabel
{
	self = [super init];
	if (self) {
		_blocksQueue = [[CWQueue alloc] init];
		if (qLabel) {
			_queue = dispatch_queue_create([qLabel UTF8String], DISPATCH_QUEUE_SERIAL);
			_label = qLabel;
		} else {
			NSString *queueLabel = CWUUIDStringPrependedWithString(@"com.Zangetsu.CWSerialBlockQueue-");
			_queue = dispatch_queue_create([queueLabel UTF8String], DISPATCH_QUEUE_SERIAL);
			_label = queueLabel;
		}
	}
	return self;
}

/**
 Returns a new CWSerialBlockQueue that immediately submits all operation objects in blockOperations for execution
 
 @param blockOperations a NSArray of CWSerialBlockOperatiom objects
 @return a new CWSerialBlockQueue queue that is immediately beginning to execute blockOperations
 */
-(id)initWithLabel:(NSString *)qLabel andBlockOperationObjects:(NSArray *)blockOperations
{
	self = [super init];
	if (self) {
		_blocksQueue = [[CWQueue alloc] initWithObjectsFromArray:blockOperations];
		if (qLabel) {
			_queue = dispatch_queue_create([qLabel UTF8String], DISPATCH_QUEUE_SERIAL);
			_label = qLabel;
		} else {
			NSString *queueLabel = CWUUIDStringPrependedWithString(@"com.Zangetsu.CWSerialBlockQueue-");
			_queue = dispatch_queue_create([queueLabel UTF8String], DISPATCH_QUEUE_SERIAL);
			_label = queueLabel;
		}
		for (CWSerialBlockOperation *op in blockOperations) {
			dispatch_async(_queue, ^{
				op.operationBlock();
				if (op.completionBlock) {
					op.completionBlock();
				}
			});
		}
	}
	return self;
}

/**
 Resumes executing blocks on the queue
 */
-(void)resume
{
	dispatch_resume(self.queue);
}

/**
 Stops processing all blocks on the queue
 
 This does not effect the currently executing block but stops the queue from dequeueing any more blocks
 */
-(void)suspend
{
	dispatch_suspend(self.queue);
}

-(void)addBlockOperation:(CWSerialBlockOperation *)operation
{
	if(!operation) { return; }
	
	dispatch_async(self.queue, ^{
		operation.operationBlock();
		if (operation.completionBlock) {
			operation.completionBlock();
		}
	});
}

/**
 Submits block for execution on the queue
 
 @param block the block to be executed on the queue
 */
-(void)addOperationwithBlock:(dispatch_block_t)block
{
	dispatch_async(self.queue, block);
}

/**
 Synchronously waits for all currently enqued blocks to finish dequeing
 */
-(void)waitUntilAllBlocksHaveProcessed
{
	dispatch_barrier_sync(self.queue, ^{ });
}

/**
 Asynchronously waits for all currently enqued blocks to finish and then executes block
 
 @param block the block to be executed once all operation opjects are finished executing
 */
-(void)executeWhenAllBlocksHaveFinished:(dispatch_block_t)block
{
	dispatch_barrier_async(self.queue, block);
}

-(void)dealloc
{
	dispatch_release(self.queue);
}

@end
