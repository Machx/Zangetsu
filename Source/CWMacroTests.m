/*
//  CWMacroTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 8/13/11.
//  Copyright 2012. All rights reserved.
//
 	*/

#import "CWMacroTests.h"
#import "CWMacros.h"

SpecBegin(CWMacroTests)

describe(@"test NSSET() Macro", ^{
	it(@"should create an idental set to apples api", ^{
		const NSString *q1 = @"All Hail Hypnotoad!";
		const NSString *q2 = @"We just need to hit the bullseye and all the dominos will fall like a house of cards... checkmate";
		NSSet *set1 = NSSET(q1,q2);
		NSSet *set2 = [NSSet setWithObjects:q1,q2, nil];
		
		expect(set1).to.equal(set2);
	});
});

describe(@"test gcdqueue macros", ^{
	it(@"should return the proper gcd queues", ^{
		expect(CWGCDPriorityQueueHigh() == dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)).to.beTruthy();
		expect(CWGCDPriorityQueueNormal() == dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)).to.beTruthy();
		expect(CWGCDPriorityQueueLow() == dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)).to.beTruthy();
		expect(CWGCDPriorityQueueBackground() == dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)).to.beTruthy();
	});
});

SpecEnd
