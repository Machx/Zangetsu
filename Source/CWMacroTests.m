/*
//  CWMacroTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 8/13/11.
//  Copyright 2011. All rights reserved.
//
 
 Copyright (c) 2011 Colin Wheeler
 
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

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

-(void)testDictionaryMacro {
    const NSString *value1 = @"I'll be in the dome of understanding";
    const NSString *key1 = @"aKey";
    
    NSDictionary *dict1 = NSDICT(value1,key1);
    NSDictionary *dict2 = [NSDictionary dictionaryWithObject:value1 forKey:key1];
    
	STAssertEqualObjects(dict1, dict2, @"Dictionaries should be the same if created correctly");
}

-(void)testArrayMacro {
    const NSString *value1 = @"Fry";
    const NSString *value2 = @"Bender";
    const NSString *value3 = @"Leela";
    
    NSArray *array1 = NSARRAY(value1,value2,value3);
    NSArray *array2 = [NSArray arrayWithObjects:value1,value2,value3, nil];
    
	STAssertEqualObjects(array1, array2, @"Arrays should be equal if created correctly");
}

-(void)testBoolMacro {
    NSNumber *bool1 = NSBOOL(YES);
    BOOL bool2 = YES;
    
	STAssertEquals([bool1 boolValue], bool2, @"BOOL values should be the same");
    
    NSNumber *bool3 = NSBOOL(NO);
    BOOL bool4 = NO;
    
    STAssertEquals([bool3 boolValue], bool4, @"BOOL values should be the same");
    STAssertFalse([bool3 boolValue] == [bool1 boolValue], @"bools formed from NSNumber should have different values");
}

-(void)testSetMacro {
    
    const NSString *q1 = @"All Hail Hypnotoad!";
    const NSString *q2 = @"We just need to hit the bullseye and all the dominos will fall like a house of cards... checkmate";
    
    NSSet *set1 = NSSET(q1,q2);
    NSSet *set2 = [NSSet setWithObjects:q1,q2, nil];
    
	STAssertEqualObjects(set1, set2, @"The 2 sets should have the same content");
}

-(void)testGCDQueueMacros {
    //make sure our GCD macros correspond to the proper queues...
    STAssertTrue(CWGCDQueueHigh() == dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), @"Queues should be the same");
    STAssertTrue(CWGCDQueueNormal() == dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), @"Queues should be the same");
    STAssertTrue(CWGCDQueueLow() == dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), @"Queues should be the same");
    STAssertTrue(CWGCDQueueBackground() == dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), @"Queues should be the same");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
