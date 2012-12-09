/*
//  CWApplicationRegistryTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 6/9/11.
//  Copyright 2012. All rights reserved.
//
 	*/

#import "CWApplicationRegistryTests.h"
#import "CWApplicationRegistry.h"

/**
 These tests are designed to be run inside of Xcode, so its not a bad assumption
 to make that it should be running, otherwise the only other application we could
 test that is guaranteed to be running is Finder	*/

@implementation CWApplicationRegistryTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

-(void)testIsAppRunning
{
	STAssertTrue([CWApplicationRegistry applicationIsRunning:@"Xcode"], @"Xcode should be running");
	STAssertFalse([CWApplicationRegistry applicationIsRunning:@"Hypnotoad33333345555"], @"Pretty good chance there will never be an app named this");
}

-(void)testBundleIdentifierForApp
{
	STAssertNotNil([CWApplicationRegistry bundleIdentifierForApplication:@"Xcode"], @"bundleid should not be nil");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
