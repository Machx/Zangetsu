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

@end
