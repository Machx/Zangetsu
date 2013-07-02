/*
//  CWBlockQueueTests.m
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

#import "CWBlockQueueTests.h"
#import "CWBlockQueue.h"
#import "CWAssertionMacros.h"

/**
 For the Expecta ...will.equal()...
 These tests use the default 1.0 second timeout
 */

SpecBegin(CWBlockQueue)

it(@"should execute a basic block operation asap", ^{
	__block NSString *result = nil;
	
	CWBlockQueue *queue = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetPrivateQueue
													   concurrent:YES
															label:nil];
	[queue addoperationWithBlock:^{
		result = @"Hello World!";
	}];
	
	expect(result).will.equal(@"Hello World!");
});

it(@"should execute synchronous operations synchronously", ^{
	__block NSInteger result = 0;
	CWBlockQueue *queue = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetPrivateQueue
													   concurrent:YES
															label:nil];
	
	[queue addSynchronousOperationWithBlock:^{
		result = 42;
	}];
	
	expect(result == 42).to.beTruthy();
	
	CWBlockOperation *op = [CWBlockOperation operationWithBlock:^{
		result = 1729;
	}];
	[queue addSynchronousOperation:op];
	
	expect(result == 1729).to.beTruthy();
});

describe(@"-isEqual", ^{
	it(@"should correctly return if queues are equal", ^{
		CWBlockQueue *queue1 = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetMainQueue
															concurrent:NO
																 label:nil];
		
		CWBlockQueue *queue2 = [[CWBlockQueue alloc] initWithGCDQueue:dispatch_get_main_queue()];
		
		expect([queue1 isEqual:queue2]).to.beTruthy();
		
		CWBlockQueue *queue3 = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetPrivateQueue
															concurrent:NO
																 label:nil];
		
		expect([queue1 isEqual:queue3]).to.beFalsy();
	});
});

describe(@"-label", ^{
	it(@"should correctly return a queues label", ^{
		const NSString *label = @"TestQueue";
		CWBlockQueue *queue = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetPrivateQueue
														   concurrent:NO
																label:(NSString *)label];
		
		expect([queue label]).to.equal(label);
	});
});

describe(@"-executeWhenAllBlocksHaveFinished", ^{
	it(@"should only execute a block once all enqueued operations finished", ^{
		CWBlockQueue *queue = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetPrivateQueue
														   concurrent:YES
																label:nil];
		
		__block int32_t count = 0;
		
		[queue addoperationWithBlock:^{
			OSAtomicIncrement32(&count);
		}];
		
		[queue addoperationWithBlock:^{
			OSAtomicIncrement32(&count);
		}];
		
		[queue addoperationWithBlock:^{
			OSAtomicIncrement32(&count);
		}];
		
		[queue executeWhenQueueIsFinished:^{
			expect(count == 3).to.beTruthy();
		}];
	});
});

it(@"should wait for all operations to finish executing", ^{
	CWBlockQueue *queue = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetPrivateQueue
													   concurrent:NO
															label:nil];
	
	__block int32_t count = 0;
	
	CWBlockOperation *op1 = [CWBlockOperation operationWithBlock:^{
		OSAtomicIncrement32(&count);
	}];
	
	CWBlockOperation *op2 = [CWBlockOperation operationWithBlock:^{
		OSAtomicIncrement32(&count);
	}];
	
	CWBlockOperation *op3 = [CWBlockOperation operationWithBlock:^{
		OSAtomicIncrement32(&count);
	}];
	
	CWBlockOperation *op4 = [CWBlockOperation operationWithBlock:^{
		OSAtomicIncrement32(&count);
	}];
	
	[queue addOperation:op1];
	[queue addOperation:op2];
	[queue addOperation:op3];
	[queue addOperation:op4];
	[queue waitUntilAllBlocksHaveProcessed];
	
	expect(count == 4).to.beTruthy();
});

it(@"should execute a block on a temporary queue", ^{
	__block BOOL didExecute = NO;
	
	[CWBlockQueue executeBlockOnTemporaryQueue:^{
		didExecute = YES;
	}];
	
	expect(didExecute == YES).will.beTruthy();
});

it(@"should suspend and resume the queue when expected", ^{
	CWBlockQueue *queue = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetPrivateQueue
													   concurrent:YES
															label:nil];
	
	[queue suspend];
	
	__block BOOL didExecute = NO;
	
	[queue addoperationWithBlock:^{
		didExecute = YES;
	}];
	
	expect(didExecute == NO).to.beTruthy();
	
	[queue resume];
	
	expect(didExecute == YES).will.beTruthy();
});

it(@"make sure we get back unique labels from queues", ^{
	CWBlockQueue *queue1 = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetPrivateQueue
														concurrent:NO
															 label:nil];
	CWBlockQueue *queue2 = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetPrivateQueue
														concurrent:NO
															 label:nil];
	CWBlockQueue *queue3 = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetPrivateQueue
														concurrent:NO
															 label:nil];
	
	NSString *label1 = queue1.label;
	NSString *label2 = queue2.label;
	NSString *label3 = queue3.label;
	
	expect(label1).notTo.equal(label2);
	expect(label1).notTo.equal(label3);
	expect(label2).notTo.equal(label3);
});

describe(@"test gcd type queues", ^{
	it(@"should get the type of gcd global queue expected", ^{
		CWBlockQueue *high = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetGCDHighPriority
														  concurrent:NO
															   label:nil];
		CWBlockQueue *normal = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetGCDNormalPriority
															concurrent:NO
																 label:nil];
		CWBlockQueue *low = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetGCDLowPriority
														 concurrent:NO
															  label:nil];
		
		expect(high.queue == dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)).to.beTruthy();
		expect(normal.queue == dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)).to.beTruthy();
		expect(low.queue == dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)).to.beTruthy();
	});
});

SpecEnd
