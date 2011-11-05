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
	
	[queue enumerateObjectsInQueue:^(id object) {
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

@end
