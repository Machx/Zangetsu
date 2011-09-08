//
//  NSMutableArrayAdditionsTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 9/8/11.
//  Copyright 2011. All rights reserved.
//

#import "NSMutableArrayAdditionsTests.h"
#import "NSMutableArrayAdditions.h"

@implementation NSMutableArrayAdditionsTests

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
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
