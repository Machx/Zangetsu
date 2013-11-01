/*
//  CWBlockQueue.m
//  Zangetsu
//
//  Created by Colin Wheeler on 2/27/12.
//  Copyright (c) 2012. All rights reserved.
//
 
 Copyright (c) 2013, Colin Wheeler
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 - Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "CWBlockQueue.h"
#import <libkern/OSAtomic.h> //for OSAtomicIncrement64()
#import "CWAssertionMacros.h" //for CWParameterAssert()

@interface CWBlockOperation()
@property(copy) dispatch_block_t operationBlock;
@end

@implementation CWBlockOperation

-(id)initWithBlock:(dispatch_block_t)block {
	self = [super init];
	if (self == nil) return nil;
	
	_operationBlock = [block copy];
	
	return self;
}

+(instancetype)operationWithBlock:(dispatch_block_t)block {
	CWAssert(block != nil);
	return [[self alloc] initWithBlock:block];
}

@end

@interface CWBlockQueue()
-(dispatch_queue_t)_getDispatchQueueWithType:(NSInteger)type 
								  concurrent:(BOOL)concurrent 
									andLabel:(NSString *)label;
@property(readwrite,assign) dispatch_queue_t queue; //the queue that CWBlockQueue manages
@end

static int64_t count = 0;

@implementation CWBlockQueue

-(instancetype)initWithQueueType:(CWBlockQueueTargetType)type
			concurrent:(BOOL)concurrent 
				 label:(NSString *)label {
	self = [super init];
	if (self == nil) return nil;
	
	_queue = [self _getDispatchQueueWithType:type
								  concurrent:concurrent
									andLabel:label];
	
	return self;
}

-(instancetype)initWithGCDQueue:(dispatch_queue_t)gcdQueue {
	self = [super init];
	if (self == nil) return nil;
	
	_queue = gcdQueue;
	
	return self;
}

-(NSString *)label {
	//Because queue_get_label blows up with NULL refs
	if (self.queue == NULL) return kCWBlockQueueNoQueueLabel;
	
	const char *gcdLabel = dispatch_queue_get_label(self.queue);
	//Because stringWithUTF8String will blow up with NULL
	//we can get here if the queue doesn't have a label
	if (gcdLabel == NULL) return kCWBlockQueueGenericGCDQueueLabel;
	
	return [NSString stringWithUTF8String:gcdLabel];
}

-(dispatch_queue_t)_getDispatchQueueWithType:(NSInteger)type 
								  concurrent:(BOOL)concurrent 
									andLabel:(NSString *)qLabel {
	dispatch_queue_t queue = NULL;
	if (type == kCWBlockQueueTargetPrivateQueue) {
		dispatch_queue_attr_t queueConcurrentAttribute = (concurrent ? DISPATCH_QUEUE_CONCURRENT : DISPATCH_QUEUE_SERIAL);
		if (qLabel) {
			queue = dispatch_queue_create([qLabel UTF8String], queueConcurrentAttribute);
		} else {
			NSString *aLabel = [NSString stringWithFormat:@"com.Zangetsu.CWBlockQueue_%lli",OSAtomicIncrement64(&count)];
			queue = dispatch_queue_create([aLabel UTF8String], queueConcurrentAttribute);
		}
		
	} else if (type == kCWBlockQueueTargetGCDHighPriority) {
		queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
		
	} else if (type == kCWBlockQueueTargetGCDNormalPriority) {
		queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
		
	} else if (type == kCWBlockQueueTargetGCDLowPriority) {
		queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
	
	} else if (type == kCWBlockQueueTargetMainQueue) {
		queue = dispatch_get_main_queue();
	}
	return queue;
}

-(void)setTargetCWBlockQueue:(CWBlockQueue *)blockQueue {
	if (blockQueue) dispatch_set_target_queue(self.queue, [blockQueue queue]);
}

-(void)setTargetGCDQueue:(dispatch_queue_t)GCDQueue {
	if (GCDQueue) dispatch_set_target_queue(self.queue, GCDQueue);
}

+(instancetype)mainQueue {
	static CWBlockQueue *mainBlockQueue = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		mainBlockQueue = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetMainQueue 
													  concurrent:NO 
														   label:nil];
	});
	return mainBlockQueue;
}

+(instancetype)globalDefaultQueue {
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
	CWAssert(block != nil);
	
	static int64_t temporaryQueueCounter = 0;
	NSString *tempLabel = [NSString stringWithFormat:@"com.Zangetsu.CWBlockQueue_TemporaryQueue_%llu",
						   OSAtomicIncrement64(&temporaryQueueCounter)];
	
	dispatch_queue_t tempQueue = dispatch_queue_create([tempLabel UTF8String], DISPATCH_QUEUE_SERIAL);
	dispatch_async(tempQueue, block);
	dispatch_release(tempQueue);
}

-(void)addOperation:(CWBlockOperation *)operation {
	dispatch_async(self.queue, ^{
		operation.operationBlock();
	});
}

-(void)addoperationWithBlock:(dispatch_block_t)block {
	dispatch_async(self.queue, block);
}

-(void)addSynchronousOperation:(CWBlockOperation *)operation {
	dispatch_sync(self.queue, ^{
		operation.operationBlock();
	});
}

-(void)addSynchronousOperationWithBlock:(dispatch_block_t)block {
	dispatch_sync(self.queue, block);
}

-(void)executeWhenQueueIsFinished:(dispatch_block_t)block {
	dispatch_barrier_async(self.queue,block);
}

-(void)waitUntilAllBlocksHaveProcessed {
	dispatch_barrier_sync(self.queue, ^{ });
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

@end
