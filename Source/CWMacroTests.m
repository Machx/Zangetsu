//
//  CWMacroTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 8/13/11.
//  Copyright 2011. All rights reserved.
//

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
    
    STAssertTrue([dict1 isEqualToDictionary:dict2], @"Dictionaries should be the same");
}

-(void)testArrayMacro {
    
    const NSString *value1 = @"Fry";
    const NSString *value2 = @"Bender";
    const NSString *value3 = @"Leela";
    
    NSArray *array1 = NSARRAY(value1,value2,value3);
    NSArray *array2 = [NSArray arrayWithObjects:value1,value2,value3, nil];
    
    STAssertTrue([array1 isEqualToArray:array2], @"Arrays should be equal");
}

-(void)testBoolMacro {
    
    NSNumber *bool1 = NSBOOL(YES);
    BOOL bool2 = YES;
    
    STAssertTrue([bool1 boolValue] == bool2, @"BOOL values should be the same");
    
    NSNumber *bool3 = NSBOOL(NO);
    BOOL bool4 = NO;
    
    STAssertTrue([bool3 boolValue] == bool4, @"Bool values should be the same");
    
    STAssertFalse([bool3 boolValue] == [bool1 boolValue], @"bools formed from NSNumber should have different values");
}

-(void)testSetMacro {
    
    const NSString *q1 = @"All Hail Hypnotoad!";
    const NSString *q2 = @"We just need to hit the bullseye and all the dominos will fall like a house of cards... checkmate";
    
    NSSet *set1 = NSSET(q1,q2);
    NSSet *set2 = [NSSet setWithObjects:q1,q2, nil];
    
    STAssertTrue([set1 isEqualToSet:set2], @"The 2 sets should be equal in content");
}

-(void)testGCDQueueMacros {
    //make sure our GCD macros correspond to the proper queues...
    STAssertTrue(CWGCDQueueHigh() == dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), @"Queues should be the same");
    STAssertTrue(CWGCDQueueNormal() == dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), @"Queues should be the same");
    STAssertTrue(CWGCDQueueLow() == dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), @"Queues should be the same");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
