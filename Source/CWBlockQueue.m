/*
//  CWBlockQueue.m
//  Zangetsu
//
//  Created by Colin Wheeler on 2/27/12.
//  Copyright (c) 2012. All rights reserved.
//
 
 Copyright (c) 2012 Colin Wheeler
 
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

#import "CWBlockQueue.h"

@interface CWBlockOperation()
@property(copy) dispatch_block_t operationBlock;
@end

@implementation CWBlockOperation

-(id)initWithBlock:(dispatch_block_t)block {
	self = [super init];
	if (self) {
		_operationBlock = [block copy];
		_completionBlock = NULL;
	}
	return self;
}

+(CWBlockOperation *)operationWithBlock:(dispatch_block_t)block {
	NSParameterAssert(block != nil);
	return [[self alloc] initWithBlock:block];
}

@end

@interface CWBlockQueue()
-(dispatch_queue_t)_getDispatchQueueWithType:(NSInteger)type 
								  concurrent:(BOOL)concurrent 
									andLabel:(NSString *)label;
@property(readwrite,assign) dispatch_queue_t queue; //the queue that CWBlockQueue manages
@property(readwrite,retain) NSString *label;
@end

static int64_t count = 0;

@implementation CWBlockQueue

-(id)initWithQueueType:(CWBlockQueueTargetType)type 
			concurrent:(BOOL)concurrent 
				 label:(NSString *)label {
	self = [super init];
	if (self) {
		_queue = [self _getDispatchQueueWithType:type 
									  concurrent:concurrent 
										andLabel:label];
	}
	return self;
}

-(id)initWithGCDQueue:(dispatch_queue_t)gcdQueue {
	self = [super init];
	if (self) {
		_queue = gcdQueue;
	}
	return self;
}

-(dispatch_queue_t)_getDispatchQueueWithType:(NSInteger)type 
								  concurrent:(BOOL)concurrent 
									andLabel:(NSString *)qLabel {
	dispatch_queue_t queue = NULL;
	if (type == kCWBlockQueueTargetPrivateQueue) {
		dispatch_queue_attr_t queueConcurrentAttribute = (concurrent ? DISPATCH_QUEUE_CONCURRENT : DISPATCH_QUEUE_SERIAL);
		if (qLabel) {
			queue = dispatch_queue_create([qLabel UTF8String], queueConcurrentAttribute);
			self.label = qLabel;
		} else {
			NSString *aLabel = [NSString stringWithFormat:@"com.Zangetsu.CWBlockQueue_%lli",OSAtomicIncrement64(&count)];
			queue = dispatch_queue_create([aLabel UTF8String], queueConcurrentAttribute);
			self.label = aLabel;
		}
		
	} else if (type == kCWBlockQueueTargetGCDHighPriority) {
		queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
		self.label = @"CWBlockQueue [GCD Global High Priority Queue]";
	
	} else if (type == kCWBlockQueueTargetGCDNormalPriority) {
		queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
		self.label = @"CWBlockQueue [GCD Global Default Priority Queue]";
	
	} else if (type == kCWBlockQueueTargetGCDLowPriority) {
		queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
		self.label = @"CWBlockQueue [GCD Global High Priority Queue]";
	
	} else if (type == kCWBlockQueueTargetMainQueue) {
		queue = dispatch_get_main_queue();
		self.label = @"CWBlockQueue [GCD Main Queue]";
	}
	return queue;
}

-(void)setTargetCWBlockQueue:(CWBlockQueue *)blockQueue {
	if (blockQueue) dispatch_set_target_queue(self.queue, [blockQueue queue]);
}

-(void)setTargetGCDQueue:(dispatch_queue_t)GCDQueue {
	if (GCDQueue) dispatch_set_target_queue(self.queue, GCDQueue);
}

+(CWBlockQueue *)mainQueue {
	static CWBlockQueue *mainBlockQueue = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		mainBlockQueue = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetMainQueue 
													  concurrent:NO 
														   label:nil];
	});
	return mainBlockQueue;
}

+(CWBlockQueue *)globalDefaultQueue {
	static CWBlockQueue *gcdDefaultQueue = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		gcdDefaultQueue = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetGCDNormalPriority 
													   concurrent:NO //bool flag ignored here
															label:nil];
	});
	return gcdDefaultQueue;
}

+(void)executeBlockOnTemporaryQueue:(dispatch_block_t)block {
	const char *label = [CWUUIDStringPrependedWithString(@"com.Zangetsu.CWBlockQueue_TemporaryQueue_") UTF8String];
	dispatch_queue_t tempQueue = dispatch_queue_create(label, DISPATCH_QUEUE_SERIAL);
	dispatch_async(tempQueue, block);
	dispatch_release(tempQueue);
}

-(void)addOperation:(CWBlockOperation *)operation {
	dispatch_async(self.queue, ^{
		operation.operationBlock();
		if (operation.completionBlock) operation.completionBlock();
	});
}

-(void)addoperationWithBlock:(dispatch_block_t)block {
	dispatch_async(self.queue, block);
}

-(void)addSynchronousOperation:(CWBlockOperation *)operation {
	dispatch_sync(self.queue, ^{
		operation.operationBlock();
		if (operation.completionBlock) operation.completionBlock();
	});
}

-(void)addSynchronousOperationWithBlock:(dispatch_block_t)block {
	dispatch_sync(self.queue, block);
}

-(void)executeWhenQueueIsFinished:(dispatch_block_t)block {
	dispatch_barrier_async(self.queue,block);
}

-(void)waitUntilAllBlocksHaveProcessed {
	dispatch_barrier_sync(self.queue, ^{
		CWDebugLog(@"Queue %@ Finished",self);
	});
}

-(void)suspend {
	dispatch_suspend(self.queue);
}

-(void)resume {
	dispatch_resume(self.queue);
}

/**
 Returns if the CWBlockQueues gcd queues are the same
 */
-(BOOL)isEqual:(id)object {
	if ([object isMemberOfClass:[self class]]) return (self.queue == [object queue]);
	return NO;
}

-(void)dealloc
{
	if (( self.queue != dispatch_get_main_queue() ) &&
		( self.queue != CWGCDPriorityQueueHigh() ) &&
		( self.queue != CWGCDPriorityQueueNormal() ) &&
		( self.queue != CWGCDPriorityQueueLow() )) {
		//make sure we only release on a private queue
		//doing this on the global concurrent queues does nothing
		dispatch_release(_queue); 
	}
}

@end
