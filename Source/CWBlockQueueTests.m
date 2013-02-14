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

//TODO: test waiting for operations to finish...

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
													   concurrent:NO
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

//TODO: consider making api name same as serial block queue?
describe(@"-executeWhenAllBlocksHaveFinished", ^{
	it(@"should only execute a block once all enqueued operations finished", ^{
		CWBlockQueue *queue = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetPrivateQueue
														   concurrent:YES
																label:nil];
		
		__block NSNumber *count = @(0);
		
		[queue addoperationWithBlock:^{
			@synchronized(count) {
				count = @(count.intValue + 1);
			}
		}];
		
		[queue addoperationWithBlock:^{
			@synchronized(count) {
				count = @(count.intValue + 1);
			}
		}];
		
		[queue addoperationWithBlock:^{
			@synchronized(count) {
				count = @(count.intValue + 1);
			}
		}];
		
		[queue executeWhenQueueIsFinished:^{
			expect(count).to.equal(@(3));
		}];
	});
});

SpecEnd
