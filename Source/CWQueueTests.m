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
	
	[queue dequeueTopObject];
	
	STAssertNil([queue dequeueTopObject], @"There should be no objects in the queue so the dequeued object should be nil");
}

@end
