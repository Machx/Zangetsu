//
//  CWQueueTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 10/30/11.
//  Copyright (c) 2011. All rights reserved.
//

#import "CWQueueTests.h"
#import "CWQueue.h"
#import "CWAssertionMacros.h"

@implementation CWQueueTests

-(void)testBasicDequeuing
{
	/**
	 CWQueue is a basic FIFO (First In First Out) Data Structure
	 The test here is to make sure the data structure works in a simple level.
	 4 items are added, and then are dequeued. While dequeueing the objects
	 more items are added on. The queue should always dequeue the items in order
	 regardless of the order in which you are adding & removing items from the queue.
	 */
	
	CWQueue *queue = [[CWQueue alloc] init];
	
	[queue enqueue:@"First"];
	[queue enqueue:@"Second"];
	[queue enqueue:@"Third"];
	[queue enqueue:@"Fourth"];
	 
	CWAssertEqualsStrings([queue dequeue], @"First");
	[queue enqueue:@"Fifth"];
	CWAssertEqualsStrings([queue dequeue], @"Second");
	[queue enqueue:@"Sixth"];
	CWAssertEqualsStrings([queue dequeue], @"Third");
	[queue enqueue:@"Seventh"];
	CWAssertEqualsStrings([queue dequeue], @"Fourth");
	[queue enqueue:@"Eight"];

	CWAssertEqualsStrings([queue dequeue], @"Fifth");
	CWAssertEqualsStrings([queue dequeue], @"Sixth");
	CWAssertEqualsStrings([queue dequeue], @"Seventh");
	CWAssertEqualsStrings([queue dequeue], @"Eight");
	STAssertNil([queue dequeue], @"There should be no more objects and therefore the object should be nil");
}

-(void)testEnumeration
{
	/**
	 Testing the enumeration of CWQueue objects and making sure
	 that the initWithObjectsFromArray API works correctly as well
	 */
	
	CWQueue *queue = [[CWQueue alloc] initWithObjectsFromArray:[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",nil]];
	
	__block NSUInteger index = 0;
	
	[queue enumerateObjectsInQueue:^(id object, BOOL *stop) {
		index++;
		switch (index) {
			case 1:
				CWAssertEqualsStrings(object, @"1");
				break;
			case 2:
				CWAssertEqualsStrings(object, @"2");
				break;
			case 3:
				CWAssertEqualsStrings(object, @"3");
				break;
			case 4:
				CWAssertEqualsStrings(object, @"4");
				break;
			case 5:
				CWAssertEqualsStrings(object, @"5");
				break;
			default:
				STAssertTrue(0, @"Should not arrive at this option if enumeration worked correctly");
		}
	}];
}

-(void)testEnumerationStopBlock
{
	CWQueue *queue = [[CWQueue alloc] initWithObjectsFromArray:[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",nil]];
	__block NSUInteger count = 0;
	
	[queue enumerateObjectsInQueue:^(id object, BOOL *stop) {
		count++;
		if ([(NSString *)object isEqualToString:@"4"]) {
			*stop = YES;
		}
	}];
	
	STAssertTrue(count == 4, @"Enumeratin should have stopped after hitting 4th object");
}

-(void)testNilDequeuedObject
{
	CWQueue *queue = [[CWQueue alloc] init];
	
	STAssertNil([queue dequeue], @"There are no objects in the queue so dequeued object should be nil");
	
	[queue enqueue:@"Fishy Joes"];
	
	STAssertTrue([queue count] == 1, @"Queue should have an object count of 1 now");
	
	STAssertNotNil([queue dequeue], @"Dequing a queue with 1 object on it should return a non nil object");
	
	STAssertNil([queue dequeue], @"There should be no objects in the queue so the dequeued object should be nil");
}

-(void)testEqualCWQueues
{
	NSArray *array = [NSArray arrayWithObject:@"Hypnotoad"];
	
	CWQueue *queue1 = [[CWQueue alloc] initWithObjectsFromArray:array];
	CWQueue *queue2 = [[CWQueue alloc] initWithObjectsFromArray:array];
	
	STAssertTrue([queue1 isEqualToQueue:queue2], @"Queues should be equal");
	
	CWQueue *queue3 = [[CWQueue alloc] initWithObjectsFromArray:[NSArray arrayWithObject:@"Nibbler"]];
	
	STAssertFalse([queue3 isEqualToQueue:queue1], @"Queues should not be equal");
}

-(void)testAddObjectsFromArray
{
	NSArray *array1 = [NSArray arrayWithObjects:@"Cheeze it!", nil];
	NSArray *array2 = [NSArray arrayWithObjects:@"Why not Zoidberg?", nil];
	
	CWQueue *queue1 = [[CWQueue alloc] initWithObjectsFromArray:array1];
	CWQueue *queue2 = [[CWQueue alloc] init];
	
	STAssertFalse([queue1 isEqualToQueue:queue2], @"Queues should not have the same contents");
	
	[queue2 enqueueObjectsFromArray:array1];
	STAssertTrue([queue1 isEqualToQueue:queue2], @"Queues should be equal");
	
	[queue1 enqueueObjectsFromArray:array2];
	[queue2 enqueueObjectsFromArray:array2];
	STAssertTrue([queue1 isEqualToQueue:queue2], @"Queues should be equal");
}

-(void)testAddNilObject
{
	CWQueue *queue = [[CWQueue alloc] init];
	STAssertTrue([queue count] == 0, @"Queue shouldn't have any objects in it");
	
	id obj = nil;
	[queue enqueue:obj];
	STAssertTrue([queue count] == 0, @"Queue shouldn't have any objects in it");
	
	NSArray *anArray = [[NSArray alloc] init];
	[queue enqueueObjectsFromArray:anArray];
	STAssertTrue([queue count] == 0, @"Queue shouldn't have any objects in it");
}

-(void)testDequeueWithBlock
{
	/**
	 Test to make sure all the objects are being correctly enumerated over and dequeued
	 */
	
	CWQueue *queue = [[CWQueue alloc] initWithObjectsFromArray:[NSArray arrayWithObjects:@"Hypnotoad",@"Bender",@"Cheeze it!", nil]];
	__block NSMutableArray *testArray = [[NSMutableArray alloc] initWithCapacity:3];
	
	[queue dequeueOueueWithBlock:^(id object, BOOL *stop) {
		[testArray addObject:object];
	}];
	
	NSArray *goodResultArray = [NSArray arrayWithObjects:@"Hypnotoad",@"Bender",@"Cheeze it!", nil];
	
	STAssertTrue([goodResultArray isEqualToArray:testArray], @"The 2 arrays should be the same if enumerated correctly");
	STAssertNil([queue dequeue], @"There shouldn't be anything left on the queue");
}

-(void)testDequeueBlockStop
{
	/**
	 Test to make sure the BOOL pointer in the block is being respected and we
	 end up with what we expect in the queue.
	 */
	
	CWQueue *queue = [[CWQueue alloc] initWithObjectsFromArray:[NSArray arrayWithObjects:@"Hypnotoad",@"Bender",@"Cheeze it!", nil]];
	__block NSMutableArray *testArray = [[NSMutableArray alloc] initWithCapacity:2];
	
	[queue dequeueOueueWithBlock:^(id object, BOOL *stop) {
		[testArray addObject:object];
		if ([(NSString *)object isEqualToString:@"Bender"]) {
			*stop = YES;
		}
	}];
	
	NSArray *goodResultArray = [NSArray arrayWithObjects:@"Hypnotoad",@"Bender", nil];
	
	STAssertTrue([goodResultArray isEqualToArray:testArray], @"The 2 arrays should be the same if the stop pointer was respected");
	STAssertNotNil([queue dequeue], @"This should be the last object on the queue");
	STAssertNil([queue dequeue], @"There shouldn't be anything left on the queue");
}

-(void)testContainsObject
{
	CWQueue *queue = [[CWQueue alloc] initWithObjectsFromArray:[NSArray arrayWithObjects:@"Hypnotoad",@"Bender",@"Cheeze it!", nil]];
	
	BOOL result1 = [queue containsObject:@"Bender"];
	STAssertTrue(result1 == YES, @"Bender should be contained within the queue");
	
	BOOL result2 = [queue containsObject:@"Cthulhu"];
	STAssertTrue(result2 == NO, @"Cthulhu isn't in the queue and thus shouldn't be found");
}

-(void)testContainsObjectWithBlock
{
	CWQueue *queue = [[CWQueue alloc] initWithObjectsFromArray:[NSArray arrayWithObjects:@"Hypnotoad",@"Bender",@"Cheeze it!", nil]];
	
	BOOL result = [queue containsObjectWithBlock:^BOOL(id obj) {
		if ([(NSString *)obj isEqualToString:@"Bender"]) {
			return YES;
		}
		return NO;
	}];
	STAssertTrue(result == YES, @"Bender should be in the queue");
	
	BOOL result2 = [queue containsObjectWithBlock:^BOOL(id obj) {
		if ([(NSString *)obj isEqualToString:@"Cthulhu"]) {
			return YES;
		}
		return NO;
	}];
	STAssertTrue(result2 == NO, @"Cthulhu should not be in the queue");
}

-(void)testDequeueToObject
{
	NSString *ob1 = @"Fry";
	NSString *ob2 = @"Leela";
	NSString *ob3 = @"Bender";
	
	CWQueue *queue = [[CWQueue alloc] init];
	[queue enqueue:ob1];
	[queue enqueue:ob2];
	[queue enqueue:ob3];
	
	[queue dequeueToObject:ob2 withBlock:^(id object) {
		//
	}];
	
	STAssertTrue([queue count] == 1, @"Queue should only have 1 object in it");
	STAssertTrue([queue containsObject:ob3], @"Bender should be in the queue");
}

@end
