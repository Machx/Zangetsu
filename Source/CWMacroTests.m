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

#import "CWMacroTests.h"
#import "CWMacros.h"

@implementation CWMacroTests

-(void)testSetMacro {
    const NSString *q1 = @"All Hail Hypnotoad!";
    const NSString *q2 = @"We just need to hit the bullseye and all the dominos will fall like a house of cards... checkmate";
    
    NSSet *set1 = NSSET(q1,q2);
    NSSet *set2 = [NSSet setWithObjects:q1,q2, nil];
    
	STAssertEqualObjects(set1, set2, @"The 2 sets should have the same content");
}

-(void)testGCDQueueMacros {
    //make sure our GCD macros correspond to the proper queues...
    STAssertTrue(CWGCDPriorityQueueHigh() == dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), @"Queues should be the same");
    STAssertTrue(CWGCDPriorityQueueNormal() == dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), @"Queues should be the same");
    STAssertTrue(CWGCDPriorityQueueLow() == dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), @"Queues should be the same");
    STAssertTrue(CWGCDPriorityQueueBackground() == dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), @"Queues should be the same");
}

@end
