/*
//  CWURLAdditionTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/22/11.
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

#import "CWURLTests.h"
#import <Zangetsu/Zangetsu.h>

static NSString * const kAppleURLString = @"http://www.apple.com";

@implementation CWURLAdditionTests

- (void)setUp {
    [super setUp];
    
    // Set-up code here.
}

-(void)testCWURL {
	NSURL *appleURL = CWURL(kAppleURLString);
	
	STAssertTrue([appleURL isEqual:[NSURL URLWithString:kAppleURLString]], @"2 URL objects should have the same value");
}

-(void)testCWURLV {
	NSURL *appleURL2 = CWURL(@"%@/%@",kAppleURLString,@"macosx");
	
	NSString *urlString = [NSString stringWithFormat:@"%@/%@",kAppleURLString,@"macosx"];
	
	STAssertTrue([appleURL2 isEqual:[NSURL URLWithString:urlString]], @"2 URL objects should have the same value");
}

- (void)tearDown {
    // Tear-down code here.
    
    [super tearDown];
}

@end
