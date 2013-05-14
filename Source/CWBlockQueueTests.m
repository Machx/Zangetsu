//
//  CWBlockQueueTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 2/27/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "CWBlockQueueTests.h"
#import "CWBlockQueue.h"
#import "CWAssertionMacros.h"

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

it(@"should execute a completion block if present", ^{
	__block NSString *result = nil;
	CWBlockQueue *queue = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetPrivateQueue
													   concurrent:YES
															label:nil];
	
	CWBlockOperation *operation = [CWBlockOperation operationWithBlock:^{
		NSLog(@"Obey Hypnotoad!");
	}];
	[operation setCompletionBlock:^{
		result = @"Obey Hypnotoad!";
	}];
	
	[queue addOperation:operation];
	
	expect(result).will.equal(@"Obey Hypnotoad!");
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

SpecEnd
