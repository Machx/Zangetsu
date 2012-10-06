//
//  NSMutableArrayAdditionsTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 9/8/11.
//  Copyright 2012. All rights reserved.
//

#import "CWNSMutableArrayAdditionsTests.h"
#import "NSArrayAdditions.h"
#import "NSMutableArrayAdditions.h"

@implementation CWNSMutableArrayAdditionsTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

-(void)testArrayByCopying
{    
    NSMutableArray *array1 = [[NSMutableArray alloc] initWithObjects:@"Hypnotoad",@"Leela",@"Amy",nil];
    NSMutableArray *array2 = [[NSMutableArray alloc] init];
    [array2 cw_addObjectsFromArrayByCopying:array1];
    
	STAssertEqualObjects(array1, array2, @"Arrays should be the same");
    
    for (NSUInteger i = 0; i < [array1 count]; i++) {
        id obj1 = [array1 objectAtIndex:i];
        id obj2 = [array2 objectAtIndex:i];
        
        STAssertTrue(&obj1 != &obj2, @"shouldn't be at the same memory address if copied");
    }
}

-(void)testMoveObjectToIndex
{
	NSMutableArray *array = [[NSMutableArray alloc] initWithArray:@[ @0, @1, @5, @2, @3, @4]];
	
	[array cw_moveObject:@5 toIndex:5];
	
	[array cw_each:^(id object, NSUInteger index, BOOL *stop) {
		STAssertEqualObjects(object, @(index), nil);
	}];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
