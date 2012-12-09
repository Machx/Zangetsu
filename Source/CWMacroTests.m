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

@implementation CWMacroTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

-(void)testSetMacro
{
    const NSString *q1 = @"All Hail Hypnotoad!";
    const NSString *q2 = @"We just need to hit the bullseye and all the dominos will fall like a house of cards... checkmate";
    
    NSSet *set1 = NSSET(q1,q2);
    NSSet *set2 = [NSSet setWithObjects:q1,q2, nil];
    
	STAssertEqualObjects(set1, set2, @"The 2 sets should have the same content");
}

-(void)testGCDQueueMacros
{
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
