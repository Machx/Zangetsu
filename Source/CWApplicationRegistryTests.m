/*
//  CWApplicationRegistryTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 6/9/11.
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

#import "CWApplicationRegistryTests.h"
#import "CWApplicationRegistry.h"

/**
 These tests are designed to be run inside of Xcode, so its not a bad assumption
 to make that it should be running, otherwise the only other application we could
 test that is guaranteed to be running is Finder
 */

@implementation CWApplicationRegistryTests

- (void)setUp {
    [super setUp];
    
    // Set-up code here.
}

-(void)testIsAppRunning {
	STAssertTrue([CWApplicationRegistry applicationIsRunning:@"Xcode"], @"Xcode should be running");
	STAssertFalse([CWApplicationRegistry applicationIsRunning:@"Hypnotoad33333345555"], @"Pretty good chance there will never be an app named this");
}

-(void)testBundleIdentifierForApp {
	STAssertNotNil([CWApplicationRegistry bundleIdentifierForApplication:@"Xcode"], @"bundleid should not be nil");
}

- (void)tearDown {
    // Tear-down code here.
    
    [super tearDown];
}

@end
