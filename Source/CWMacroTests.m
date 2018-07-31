/*
//  CWMacroTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 8/13/11.
//  Copyright 2012. All rights reserved.
//
 
 Copyright (c) 2013, Colin Wheeler
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 - Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

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
