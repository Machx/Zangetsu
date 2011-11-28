/*
//  CWFoundationTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 6/25/11.
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

#import "CWFoundationTests.h"
#import "CWFoundation.h"
#import "CWMacros.h"

@implementation CWFoundationTests

- (void)setUp {
    [super setUp];
    
    // Set-up code here.
}

-(void)testClassExists {
    STAssertTrue(CWClassExists(@"NSString"), @"NSString should exist");
    STAssertFalse(CWClassExists(@"Hypnotoad"), @"Hypnotoad class shouldn't exist");
}

-(void)testBoolString {
    //just test the 2 bool values...
    
    NSString *yesString = CWBOOLString(YES);
    STAssertTrue([yesString isEqualToString:@"YES"], @"Both strings should be 'YES'");
    
    NSString *noString = CWBOOLString(NO);
    STAssertTrue([noString isEqualToString:@"NO"], @"Both strings should be 'NO'");
	
	NSString *str = [[NSString alloc] initWithString:@"Yes"];
	NSString *str2 = CWBOOLString([str boolValue]);
	STAssertTrue([str2 isEqualToString:@"YES"], @"A valid object should return YES");
	
	NSString *str3 = nil;
	NSString *str4 = CWBOOLString([str3 boolValue]);
	STAssertTrue([str4 isEqualToString:@"NO"], @"A valid object should return YES");
}

- (void)tearDown {
    // Tear-down code here.
    
    [super tearDown];
}

@end
