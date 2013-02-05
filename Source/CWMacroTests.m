/*
//  CWMacroTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 8/13/11.
//  Copyright 2012. All rights reserved.
//
 
 Copyright (c) 2012 Colin Wheeler
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
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
