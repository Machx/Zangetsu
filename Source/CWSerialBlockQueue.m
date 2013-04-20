/*
//  CWSerialBlockQueue.m
//  Zangetsu
//
//  Created by Colin Wheeler on 2/23/12.
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

#import "CWSerialBlockQueue.h"

@interface CWSerialBlockOperation()
@property(copy) dispatch_block_t operationBlock;
@end

@implementation CWSerialBlockOperation

- (id)init {
    self = [super init];
    if (self) {
        _operationBlock = nil;
    }
    return self;
}

+(CWSerialBlockOperation *)blockOperationWithBlock:(dispatch_block_t)block {
	CWSerialBlockOperation *operation = [[self alloc] init];
	operation.operationBlock = block;
	return operation;
}

@end

@interface CWSerialBlockQueue()
@property(assign) dispatch_queue_t queue;
@end

@implementation CWSerialBlockQueue

- (id)init {
    self = [super init];
    if (self) {
		_queue = dispatch_queue_create([CWUUIDStringPrependedWithString(@"com.Zangetsu.CWSerialBlockQueue-") UTF8String], DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

-(id)initWithLabel:(NSString *)qLabel {
	self = [super init];
	if (self) {
		if (qLabel) {
			_queue = dispatch_queue_create([qLabel UTF8String], DISPATCH_QUEUE_SERIAL);
		} else {
			_queue = dispatch_queue_create([CWUUIDStringPrependedWithString(@"com.Zangetsu.CWSerialBlockQueue-") UTF8String], DISPATCH_QUEUE_SERIAL);
		}
	}
	return self;
}

-(id)initWithLabel:(NSString *)qLabel andBlockOperationObjects:(NSArray *)blockOperations {
	self = [super init];
	if (self) {
		if (qLabel) {
			_queue = dispatch_queue_create([qLabel UTF8String], DISPATCH_QUEUE_SERIAL);
		} else {
			_queue = dispatch_queue_create([CWUUIDStringPrependedWithString(@"com.Zangetsu.CWSerialBlockQueue-") UTF8String], DISPATCH_QUEUE_SERIAL);
		}
		for (CWSerialBlockOperation *op in blockOperations) {
			dispatch_async(_queue, ^{ op.operationBlock(); });
		}
	}
	return self;
}

-(NSString *)label {
	static NSString *queueLabel = nil;
	if (queueLabel == nil) {
		queueLabel = [NSString stringWithCString:dispatch_queue_get_label(self.queue)
										encoding:NSUTF8StringEncoding];
	}
	return queueLabel;
}

-(void)resume {
	dispatch_resume(self.queue);
}

-(void)suspend {
	dispatch_suspend(self.queue);
}

-(void)addBlockOperation:(CWSerialBlockOperation *)operation {
	if(!operation) return;
	dispatch_async(self.queue, ^{ operation.operationBlock(); });
}

-(void)addBlockOperationObjects:(NSArray *)operationObjects {
	for (id op in operationObjects) {
		if ([op isMemberOfClass:[CWSerialBlockOperation class]]) {
			[self addBlockOperationObjects:op];
		}
	}
}

-(void)addOperationwithBlock:(dispatch_block_t)block {
	dispatch_async(self.queue, block);
}

-(void)waitUntilAllBlocksHaveProcessed {
	dispatch_barrier_sync(self.queue, ^{ });
}

-(void)executeWhenAllBlocksHaveFinished:(dispatch_block_t)block {
	dispatch_barrier_async(self.queue, block);
}

-(void)dealloc {
	dispatch_release(_queue);
}

@end
