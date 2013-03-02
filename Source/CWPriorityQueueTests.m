//
//  CWPriorityQueueTests.m
//  ObjC_Playground
//
//  Created by Colin Wheeler on 12/19/12.
//  Copyright (c) 2012 Colin Wheeler. All rights reserved.
//

#import "CWPriorityQueueTests.h"
#import "CWPriorityQueue.h"

SpecBegin(CWPriorityQueue)

it(@"should push and pop in the order we expect", ^{
	CWPriorityQueue *queue = [CWPriorityQueue new];
	[queue addItem:@"1" withPriority:1];
	[queue addItem:@"5" withPriority:5];
	[queue addItem:@"3" withPriority:3];
	[queue addItem:@"2" withPriority:2];
	[queue addItem:@"100" withPriority:100];
	[queue addItem:@"20" withPriority:20];
	[queue addItem:@"9" withPriority:9];
	
	expect([queue dequeue]).to.equal(@"1");
	expect([queue dequeue]).to.equal(@"2");
	expect([queue dequeue]).to.equal(@"3");
	expect([queue dequeue]).to.equal(@"5");
	expect([queue dequeue]).to.equal(@"9");
	expect([queue dequeue]).to.equal(@"20");
	expect([queue dequeue]).to.equal(@"100");
});

it(@"should dequeue the objects we expect of a specific priority level", ^{
	CWPriorityQueue *queue = [CWPriorityQueue new];
	
	[queue addItem:@"All" withPriority:0];
	[queue addItem:@"Glory" withPriority:3];
	[queue addItem:@"To" withPriority:1];
	[queue addItem:@"The" withPriority:5];
	[queue addItem:@"Hypnotoad" withPriority:5];
	[queue addItem:@"Fry" withPriority:13];
	[queue addItem:@"Leela" withPriority:2];
	
	NSArray *results = [queue allObjectsOfPriority:5];
	
	expect(results).to.haveCountOf(2);
	
	NSArray *expected = @[ @"The", @"Hypnotoad" ];
	expect(results).to.equal(expected);
});

it(@"should return the correct count of objects with a given priority level", ^{
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
	
	expect([queue countofObjectsWithPriority:1] == 1).to.beTruthy();
	expect([queue countofObjectsWithPriority:2] == 1).to.beTruthy();
	expect([queue countofObjectsWithPriority:3] == 4).to.beTruthy();
	expect([queue countofObjectsWithPriority:4] == 1).to.beTruthy();
	expect([queue countofObjectsWithPriority:7] == 1).to.beTruthy();
	expect([queue countofObjectsWithPriority:9] == 2).to.beTruthy();
});

it(@"should dequeue the expected objects of next priority level", ^{
	CWPriorityQueue *queue = [CWPriorityQueue new];
	
	[queue addItem:@"1-1" withPriority:1];
	[queue addItem:@"2-1" withPriority:2];
	[queue addItem:@"2-2" withPriority:2];
	[queue addItem:@"2-3" withPriority:2];
	[queue addItem:@"2-4" withPriority:2];
	[queue addItem:@"2-5" withPriority:2];
	[queue addItem:@"3-1" withPriority:3];
	[queue addItem:@"3-2" withPriority:3];
	[queue addItem:@"3-3" withPriority:3];
	[queue addItem:@"4-1" withPriority:4];
	[queue addItem:@"4-2" withPriority:4];
	[queue addItem:@"4-3" withPriority:4];
	[queue addItem:@"4-4" withPriority:4];
	
	expect([queue dequeueAllObjectsOfNextPriorityLevel]).to.haveCountOf(1);
	expect([queue dequeueAllObjectsOfNextPriorityLevel]).to.haveCountOf(5);
	expect([queue dequeueAllObjectsOfNextPriorityLevel]).to.haveCountOf(3);
	expect([queue dequeueAllObjectsOfNextPriorityLevel]).to.haveCountOf(4);
});

it(@"should allow you to peek at the next item to be dequeued", ^{
	CWPriorityQueue *queue = [CWPriorityQueue new];
	
	expect([queue peek]).to.beNil();
	
	[queue addItem:@"Hypnotoad" withPriority:4];
	
	expect([queue peek]).to.equal(@"Hypnotoad");
});

it(@"should allow you to clear all objects off the queue", ^{
	CWPriorityQueue *queue = [CWPriorityQueue new];
	
	expect(queue.count == 0).to.beTruthy();
	[queue addItem:@1 withPriority:1];
	expect(queue.count == 1).to.beTruthy();
	
	[queue addItem:@2 withPriority:2];
	expect(queue.count == 2).to.beTruthy();
	[queue addItem:@3 withPriority:3];
	expect(queue.count == 3).to.beTruthy();
	[queue addItem:@4 withPriority:4];
	expect(queue.count == 4).to.beTruthy();
	[queue addItem:@5 withPriority:5];
	expect(queue.count == 5).to.beTruthy();
	
	[queue removeAllObjects];
	expect(queue.count == 0).to.beTruthy();
});

SpecEnd
