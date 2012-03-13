//
//  CWQueueTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 10/30/11.
//  Copyright (c) 2011. All rights reserved.
//

#import "CWQueueTests.h"
#import "CWQueue.h"

@implementation CWQueueTests

-(void)testBasicDequeuing {
	/**
	 CWQueue is a basic FIFO (First In First Out) Data Structure
	 The test here is to make sure the data structure works in a simple level.
	 4 items are added, and then are dequeued. While dequeueing the objects
	 more items are added on. The queue should always dequeue the items in order
	 regardless of the order in which you are adding & removing items from the queue.
	 */
	
	CWQueue *queue = [[CWQueue alloc] init];
	
	[queue addObject:@"First"];
	[queue addObject:@"Second"];
	[queue addObject:@"Third"];
	[queue addObject:@"Fourth"];
	
	STAssertTrue([(NSString *)[queue dequeueTopObject] isEqualToString:@"First"], @"Should be first item dequeued");
	[queue addObject:@"Fifth"];
	STAssertTrue([(NSString *)[queue dequeueTopObject] isEqualToString:@"Second"], @"Should be second item dequeued");
	[queue addObject:@"Sixth"];
	STAssertTrue([(NSString *)[queue dequeueTopObject] isEqualToString:@"Third"], @"Should be third item dequeued");
	[queue addObject:@"Seventh"];
	STAssertTrue([(NSString *)[queue dequeueTopObject] isEqualToString:@"Fourth"], @"Should be fourth item dequeued");
	[queue addObject:@"Eight"];
	
	STAssertTrue([(NSString *)[queue dequeueTopObject] isEqualToString:@"Fifth"], @"Should be fourth item dequeued");
	STAssertTrue([(NSString *)[queue dequeueTopObject] isEqualToString:@"Sixth"], @"Should be fourth item dequeued");
	STAssertTrue([(NSString *)[queue dequeueTopObject] isEqualToString:@"Seventh"], @"Should be fourth item dequeued");
	STAssertTrue([(NSString *)[queue dequeueTopObject] isEqualToString:@"Eight"], @"Should be fourth item dequeued");
	STAssertNil([queue dequeueTopObject], @"There should be no more objects and therefore the object should be nil");
}

-(void)testEnumeration {
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
				STAssertTrue([(NSString *)object isEqualToString:@"1"], @"String should be equal to 1");
				break;
			case 2:
				STAssertTrue([(NSString *)object isEqualToString:@"2"], @"String should be equal to 2");
				break;
			case 3:
				STAssertTrue([(NSString *)object isEqualToString:@"3"], @"String should be equal to 3");
				break;
			case 4:
				STAssertTrue([(NSString *)object isEqualToString:@"4"], @"String should be equal to 4");
				break;
			case 5:
				STAssertTrue([(NSString *)object isEqualToString:@"5"], @"String should be equal to 5");
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

-(void)testNilDequeuedObject {
	
	CWQueue *queue = [[CWQueue alloc] init];
	
	STAssertNil([queue dequeueTopObject], @"There are no objects in the queue so dequeued object should be nil");
	
	[queue addObject:@"Fishy Joes"];
	
	STAssertTrue([queue count] == 1, @"Queue should have an object count of 1 now");
	
	STAssertNotNil([queue dequeueTopObject], @"Dequing a queue with 1 object on it should return a non nil object");
	
	STAssertNil([queue dequeueTopObject], @"There should be no objects in the queue so the dequeued object should be nil");
}

-(void)testEqualCWQueues {
	
	NSArray *array = [NSArray arrayWithObject:@"Hypnotoad"];
	
	CWQueue *queue1 = [[CWQueue alloc] initWithObjectsFromArray:array];
	CWQueue *queue2 = [[CWQueue alloc] initWithObjectsFromArray:array];
	
	STAssertTrue([queue1 isEqualToQueue:queue2], @"Queues should be equal");
	
	CWQueue *queue3 = [[CWQueue alloc] initWithObjectsFromArray:[NSArray arrayWithObject:@"Nibbler"]];
	
	STAssertFalse([queue3 isEqualToQueue:queue1], @"Queues should not be equal");
}

-(void)testAddObjectsFromArray {
	
	NSArray *array1 = [NSArray arrayWithObjects:@"Cheeze it!", nil];
	NSArray *array2 = [NSArray arrayWithObjects:@"Why not Zoidberg?", nil];
	
	CWQueue *queue1 = [[CWQueue alloc] initWithObjectsFromArray:array1];
	CWQueue *queue2 = [[CWQueue alloc] init];
	
	STAssertFalse([queue1 isEqualToQueue:queue2], @"Queues should not have the same contents");
	
	[queue2 addObjectsFromArray:array1];
	STAssertTrue([queue1 isEqualToQueue:queue2], @"Queues should be equal");
	
	[queue1 addObjectsFromArray:array2];
	[queue2 addObjectsFromArray:array2];
	STAssertTrue([queue1 isEqualToQueue:queue2], @"Queues should be equal");
}

-(void)testAddNilObject {
	CWQueue *queue = [[CWQueue alloc] init];
	STAssertTrue([queue count] == 0, @"Queue shouldn't have any objects in it");
	
	id obj = nil;
	[queue addObject:obj];
	STAssertTrue([queue count] == 0, @"Queue shouldn't have any objects in it");
	
	NSArray *anArray = [[NSArray alloc] init];
	[queue addObjectsFromArray:anArray];
	STAssertTrue([queue count] == 0, @"Queue shouldn't have any objects in it");
}

-(void)testDequeueWithBlock {
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
	STAssertNil([queue dequeueTopObject], @"There shouldn't be anything left on the queue");
}

-(void)testDequeueBlockStop {
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
	STAssertNotNil([queue dequeueTopObject], @"This should be the last object on the queue");
	STAssertNil([queue dequeueTopObject], @"There shouldn't be anything left on the queue");
}

-(void)testContainsObject {
	CWQueue *queue = [[CWQueue alloc] initWithObjectsFromArray:[NSArray arrayWithObjects:@"Hypnotoad",@"Bender",@"Cheeze it!", nil]];
	
	BOOL result1 = [queue containsObject:@"Bender"];
	STAssertTrue(result1 == YES, @"Bender should be contained within the queue");
	
	BOOL result2 = [queue containsObject:@"Cthulhu"];
	STAssertTrue(result2 == NO, @"Cthulhu isn't in the queue and thus shouldn't be found");
}

-(void)testContainsObjectWithBlock {
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

-(void)testObjectInFrontOf
{
	NSString *ob1 = @"Fry";
	NSString *ob2 = @"Leela";
	NSString *ob3 = @"Bender";
	
	CWQueue *queue = [[CWQueue alloc] init];
	[queue addObject:ob1];
	[queue addObject:ob2];
	[queue addObject:ob3];
	
	STAssertNil([queue objectInFrontOf:ob1],@"Fry should be at the front and therefore we should get nil back");
	STAssertTrue([[queue objectInFrontOf:ob2] isEqualToString:@"Fry"],@"Pointing to the object in front of Leela should be Fry");
}

-(void)testObjectBehind
{
	NSString *ob1 = @"Fry";
	NSString *ob2 = @"Leela";
	NSString *ob3 = @"Bender";
	
	CWQueue *queue = [[CWQueue alloc] init];
	[queue addObject:ob1];
	[queue addObject:ob2];
	[queue addObject:ob3];
	
	STAssertNil([queue objectBehind:ob3],@"Bender should be the last object on the queue and therefore we should get nil back");
	STAssertTrue([[queue objectBehind:ob2] isEqualToString:@"Bender"],@"Bender should be behind leela on the queue");
}

-(void)testDequeueToObject
{
	NSString *ob1 = @"Fry";
	NSString *ob2 = @"Leela";
	NSString *ob3 = @"Bender";
	
	CWQueue *queue = [[CWQueue alloc] init];
	[queue addObject:ob1];
	[queue addObject:ob2];
	[queue addObject:ob3];
	
	[queue dequeueToObject:ob2 withBlock:^(id object) {
		//
	}];
	
	STAssertTrue([queue count] == 1, @"Queue should only have 1 object in it");
	STAssertTrue([queue containsObject:ob3], @"Bender should be in the queue");
}

@end
