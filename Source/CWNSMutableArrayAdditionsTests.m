//
//  NSMutableArrayAdditionsTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 9/8/11.
//  Copyright 2011. All rights reserved.
//

#import "CWNSMutableArrayAdditionsTests.h"
#import "NSMutableArrayAdditions.h"

@implementation CWNSMutableArrayAdditionsTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

-(void)testArrayByCopying {
    
    NSMutableArray *array1 = [[NSMutableArray alloc] initWithObjects:@"Hypnotoad",@"Leela",@"Amy",nil];
    NSMutableArray *array2 = [[NSMutableArray alloc] init];
    [array2 cw_addObjectsFromArrayByCopying:array1];
    
    STAssertTrue([array1 isEqualTo:array2],@"Arrays should be equal");
    
    for (NSUInteger i = 0; i < [array1 count]; i++) {
        id obj1 = [array1 objectAtIndex:i];
        id obj2 = [array2 objectAtIndex:i];
        
        STAssertTrue(&obj1 != &obj2, @"shouldn't be at the same memory address if copied");
    }
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
