//
//  CWQueueTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 10/30/11.
//  Copyright (c) 2012. All rights reserved.
//

#import "CWQueueTests.h"
#import "CWQueue.h"
#import "CWAssertionMacros.h"

SpecBegin(CWQueue)

describe(@"-addObjectsFromArray", ^{
	it(@"should add objects from an array just as if it was enqueueing them", ^{
		NSArray *array1 = @[ @"Cheeze it!" ];
		NSArray *array2 = @[ @"Why not Zoidberg?" ];
		
		CWQueue *queue1 = [[CWQueue alloc] initWithObjectsFromArray:array1];
		CWQueue *queue2 = [[CWQueue alloc] init];
		
		expect([queue1 isEqualToQueue:queue2]).to.beFalsy();
		
		[queue2 enqueueObjectsFromArray:array1];
		
		expect([queue1 isEqualToQueue:queue2]).to.beTruthy();
		
		[queue1 enqueueObjectsFromArray:array2];
		[queue2 enqueueObjectsFromArray:array2];
		
		expect([queue1 isEqualToQueue:queue2]).to.beTruthy();
	});
});

describe(@"-dequeue", ^{
	it(@"should dequeue items in order", ^{
		CWQueue *queue = [[CWQueue alloc] init];
		[queue enqueue:@"First"];
		[queue enqueue:@"Second"];
		[queue enqueue:@"Third"];
		[queue enqueue:@"Fourth"];
		
		expect([queue dequeue]).to.equal(@"First");
		[queue enqueue:@"Fifth"];
		expect([queue dequeue]).to.equal(@"Second");
		[queue enqueue:@"Sixth"];
		expect([queue dequeue]).to.equal(@"Third");
		[queue enqueue:@"Seventh"];
		expect([queue dequeue]).to.equal(@"Fourth");
		[queue enqueue:@"Eighth"];
		expect([queue dequeue]).to.equal(@"Fifth");
		expect([queue dequeue]).to.equal(@"Sixth");
		expect([queue dequeue]).to.equal(@"Seventh");
		expect([queue dequeue]).to.equal(@"Eighth");
	});
	
	it(@"should dequeue nil when there are no more objects on the queue", ^{
		CWQueue *queue = [[CWQueue alloc] init];
		
		expect([queue dequeue]).to.beNil();
		
		[queue enqueue:@"Fishy Joes"];
		
		expect([queue count] == 1).to.beTruthy();
		expect([queue dequeue]).notTo.beNil();
		expect([queue dequeue]).to.beNil();
	});
});

describe(@"-enumerateObjectsInQueue", ^{
	it(@"should enumerate objects in order", ^{
		CWQueue *queue = [[CWQueue alloc] initWithObjectsFromArray:[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",nil]];
		__block NSUInteger index = 0;
		[queue enumerateObjectsInQueue:^(id object, BOOL *stop) {
			index++;
			if (index == 1) {
				expect(object).to.equal(@"1");
			} else if (index == 2) {
				expect(object).to.equal(@"2");
			} else if (index == 3) {
				expect(object).to.equal(@"3");
			} else if (index == 4) {
				expect(object).to.equal(@"4");
			} else if (index == 5) {
				expect(object).to.equal(@"5");
			} else {
				STFail(@"should not reach here");
			}
		}];
	});
	
	it(@"should stop when the stop pointer is set to YES", ^{
		CWQueue *queue = [[CWQueue alloc] initWithObjectsFromArray:[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",nil]];
		
		__block NSUInteger count = 0;
		[queue enumerateObjectsInQueue:^(id object, BOOL *stop) {
			count++;
			if ([(NSString *)object isEqualToString:@"4"]) *stop = YES;
		}];
		
		expect(count == 4).to.beTruthy();
	});
});

describe(@"-enqueue", ^{
	it(@"shoudn't enqueue nil", ^{
		CWQueue *queue = [[CWQueue alloc] init];
		
		expect([queue count] == 0).to.beTruthy();
		
		id obj = nil;
		[queue enqueue:obj];
		
		expect([queue count] == 0).to.beTruthy();
		
		NSArray *anArray = [[NSArray alloc] init];
		[queue enqueueObjectsFromArray:anArray];
		
		expect([queue count] == 0).to.beTruthy();
	});
});

describe(@"-isEqualToQueue", ^{
	it(@"should correclty return if it is equal to another queue", ^{
		NSArray *array = @[ @"Hypnotoad" ];
		CWQueue *queue1 = [[CWQueue alloc] initWithObjectsFromArray:array];
		CWQueue *queue2 = [[CWQueue alloc] initWithObjectsFromArray:array];
		
		expect([queue1 isEqualToQueue:queue2]).to.beTruthy();
		
		CWQueue *queue3 = [[CWQueue alloc] initWithObjectsFromArray:@[ @"Nibbler" ]];
		
		expect([queue3 isEqualToQueue:queue1]).to.beFalsy();
	});
});

SpecEnd

//
//-(void)testDequeueWithBlock
//{
//	/**
//	 Test to make sure all the objects are being correctly enumerated over and dequeued
//	 */
//	
//	CWQueue *queue = [[CWQueue alloc] initWithObjectsFromArray:[NSArray arrayWithObjects:@"Hypnotoad",@"Bender",@"Cheeze it!", nil]];
//	__block NSMutableArray *testArray = [[NSMutableArray alloc] initWithCapacity:3];
//	
//	[queue dequeueOueueWithBlock:^(id object, BOOL *stop) {
//		[testArray addObject:object];
//	}];
//	
//	NSArray *goodResultArray = [NSArray arrayWithObjects:@"Hypnotoad",@"Bender",@"Cheeze it!", nil];
//	
//	STAssertTrue([goodResultArray isEqualToArray:testArray], @"The 2 arrays should be the same if enumerated correctly");
//	STAssertNil([queue dequeue], @"There shouldn't be anything left on the queue");
//}
//
//-(void)testDequeueBlockStop
//{
//	/**
//	 Test to make sure the BOOL pointer in the block is being respected and we
//	 end up with what we expect in the queue.
//	 */
//	
//	CWQueue *queue = [[CWQueue alloc] initWithObjectsFromArray:[NSArray arrayWithObjects:@"Hypnotoad",@"Bender",@"Cheeze it!", nil]];
//	__block NSMutableArray *testArray = [[NSMutableArray alloc] initWithCapacity:2];
//	
//	[queue dequeueOueueWithBlock:^(id object, BOOL *stop) {
//		[testArray addObject:object];
//		if ([(NSString *)object isEqualToString:@"Bender"]) {
//			*stop = YES;
//		}
//	}];
//	
//	NSArray *goodResultArray = [NSArray arrayWithObjects:@"Hypnotoad",@"Bender", nil];
//	
//	STAssertTrue([goodResultArray isEqualToArray:testArray], @"The 2 arrays should be the same if the stop pointer was respected");
//	STAssertNotNil([queue dequeue], @"This should be the last object on the queue");
//	STAssertNil([queue dequeue], @"There shouldn't be anything left on the queue");
//}
//
//-(void)testContainsObject
//{
//	CWQueue *queue = [[CWQueue alloc] initWithObjectsFromArray:[NSArray arrayWithObjects:@"Hypnotoad",@"Bender",@"Cheeze it!", nil]];
//	
//	BOOL result1 = [queue containsObject:@"Bender"];
//	STAssertTrue(result1 == YES, @"Bender should be contained within the queue");
//	
//	BOOL result2 = [queue containsObject:@"Cthulhu"];
//	STAssertTrue(result2 == NO, @"Cthulhu isn't in the queue and thus shouldn't be found");
//}
//
//-(void)testContainsObjectWithBlock
//{
//	CWQueue *queue = [[CWQueue alloc] initWithObjectsFromArray:[NSArray arrayWithObjects:@"Hypnotoad",@"Bender",@"Cheeze it!", nil]];
//	
//	BOOL result = [queue containsObjectWithBlock:^BOOL(id obj) {
//		if ([(NSString *)obj isEqualToString:@"Bender"]) {
//			return YES;
//		}
//		return NO;
//	}];
//	STAssertTrue(result == YES, @"Bender should be in the queue");
//	
//	BOOL result2 = [queue containsObjectWithBlock:^BOOL(id obj) {
//		if ([(NSString *)obj isEqualToString:@"Cthulhu"]) {
//			return YES;
//		}
//		return NO;
//	}];
//	STAssertTrue(result2 == NO, @"Cthulhu should not be in the queue");
//}
//
//-(void)testDequeueToObject
//{
//	NSString *ob1 = @"Fry";
//	NSString *ob2 = @"Leela";
//	NSString *ob3 = @"Bender";
//	
//	CWQueue *queue = [[CWQueue alloc] init];
//	[queue enqueue:ob1];
//	[queue enqueue:ob2];
//	[queue enqueue:ob3];
//	
//	[queue dequeueToObject:ob2 withBlock:^(id object) {
//		//
//	}];
//	
//	STAssertTrue([queue count] == 1, @"Queue should only have 1 object in it");
//	STAssertTrue([queue containsObject:ob3], @"Bender should be in the queue");
//}
//
//-(void)testQueueCountAndIsEmpty
//{
//	CWQueue *queue = [[CWQueue alloc] initWithObjectsFromArray:[NSArray arrayWithObject:@"Hello"]];
//	
//	STAssertTrue([queue count] == 1, @"Queue should only have 1 object");
//	STAssertFalse([queue isEmpty], @"1 object means should not be empty");
//	
//	STAssertNotNil([queue dequeue], @"Dequeue the only object");
//	
//	STAssertTrue([queue isEmpty], @"Should be empty after dequeuing the only object");
//	STAssertTrue([queue count] == 0, @"Queue count should be 0");
//}
//
//@end
