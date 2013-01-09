//
//  CWPriorityQueueTests.m
//  ObjC_Playground
//
//  Created by Colin Wheeler on 12/19/12.
//  Copyright (c) 2012 Colin Wheeler. All rights reserved.
//

#import "CWPriorityQueueTests.h"
#import "CWPriorityQueue.h"

@implementation CWPriorityQueueTests

-(void)testBasicPushAndPop
{
	CWPriorityQueue *queue = [CWPriorityQueue new];
	
	[queue addItem:@"1" withPriority:1];
	[queue addItem:@"5" withPriority:5];
	[queue addItem:@"3" withPriority:3];
	[queue addItem:@"2" withPriority:2];
	[queue addItem:@"100" withPriority:100];
	[queue addItem:@"20" withPriority:20];
	[queue addItem:@"9" withPriority:9];
	
	STAssertTrue([@"1" isEqualToString:[queue dequeue]], nil);
	STAssertTrue([@"2" isEqualToString:[queue dequeue]], nil);
	STAssertTrue([@"3" isEqualToString:[queue dequeue]], nil);
	STAssertTrue([@"5" isEqualToString:[queue dequeue]], nil);
	STAssertTrue([@"9" isEqualToString:[queue dequeue]], nil);
	STAssertTrue([@"20" isEqualToString:[queue dequeue]], nil);
	STAssertTrue([@"100" isEqualToString:[queue dequeue]], nil);
}

-(void)testObjectsOfPriority
{
	CWPriorityQueue *queue = [CWPriorityQueue new];
	
	[queue addItem:@"All" withPriority:0];
	[queue addItem:@"Glory" withPriority:3];
	[queue addItem:@"To" withPriority:1];
	[queue addItem:@"The" withPriority:5];
	[queue addItem:@"Hypnotoad" withPriority:5];
	[queue addItem:@"Fry" withPriority:13];
	[queue addItem:@"Leela" withPriority:2];
	
	NSSet *results = [queue allObjectsOfPriority:5];
	
	STAssertTrue(results.count == 2, nil);
	
	NSSet *expected = [NSSet setWithObjects:@"The",@"Hypnotoad", nil];
	STAssertTrue([expected isEqualToSet:results], nil);
}

-(void)testCountOfPriority
{
	CWPriorityQueue *queue = [CWPriorityQueue new];
	
	[queue addItem:@"1" withPriority:1];
	[queue addItem:@"2" withPriority:2];
	[queue addItem:@"3" withPriority:3];
	[queue addItem:@"3" withPriority:3];
	[queue addItem:@"3" withPriority:3];
	[queue addItem:@"3" withPriority:3];
	[queue addItem:@"4" withPriority:4];
	[queue addItem:@"7" withPriority:7];
	[queue addItem:@"9" withPriority:9];
	[queue addItem:@"9" withPriority:9];
	
	STAssertTrue([queue countofObjectsWithPriority:1] == 1, nil);
	STAssertTrue([queue countofObjectsWithPriority:2] == 1, nil);
	STAssertTrue([queue countofObjectsWithPriority:3] == 4, nil);
	STAssertTrue([queue countofObjectsWithPriority:4] == 1, nil);
	STAssertTrue([queue countofObjectsWithPriority:7] == 1, nil);
	STAssertTrue([queue countofObjectsWithPriority:9] == 2, nil);
}

@end
