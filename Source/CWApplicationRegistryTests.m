//
//  CWApplicationRegistryTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 6/9/11.
//  Copyright 2011. All rights reserved.
//

#import "CWApplicationRegistryTests.h"
#import "CWApplicationRegistry.h"

@implementation CWApplicationRegistryTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

-(void)testIsAppRunning {
	
	STAssertTrue([CWApplicationRegistry applicationIsRunning:@"Xcode"], @"Xcode should be running");
}

-(void)testBundleIdentifierForApp {
	
	STAssertNotNil([CWApplicationRegistry bundleIdentifierForApplication:@"Xcode"], @"bundleid should not be nil");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
