//
//  CWFoundationTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 6/25/11.
//  Copyright 2011. All rights reserved.
//

#import "CWFoundationTests.h"
#import "CWFoundation.h"

@implementation CWFoundationTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

-(void)testClassExists {
    
    STAssertTrue(CWClassExists(@"NSString"), @"NSString should exist");
    STAssertFalse(CWClassExists(@"Hypnotoad"), @"Hypnotoad class shouldn't exist");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
