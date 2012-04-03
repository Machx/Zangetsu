/*
//  CWNSStringTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/5/10.
//  Copyright 2010. All rights reserved.
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

#import "CWNSStringTests.h"
#import <Zangetsu/Zangetsu.h>
#import "CWAssertionMacros.h"

@implementation CWNSStringTests

-(void)testUUIDStrings
{
	NSString *string1 = [NSString cw_uuidString];
	NSString *string2 = [NSString cw_uuidString];
	
	CWAssertNotEqualsObjects(string1, string2, @"Both Strings should be unique");
}

-(void)testEmptyStringMethod
{
	//test data that should be empty
	NSString *emptyString1 = @"";
	STAssertFalse([emptyString1 cw_isNotEmptyString],@"String1 should be empty");
	
	//test data that should not return empty
	NSString *testString2 = @"Fry";
	STAssertTrue([testString2 cw_isNotEmptyString],@"TestString should not be empty");
}

-(void)testURLEscaping
{	
	NSString *urlCharsString = [NSString stringWithString:@"@!*'()[];:&=+$,/?%#"];
	
	NSString *escapedString = [urlCharsString cw_escapeEntitiesForURL];
	
	NSCharacterSet *testIllegalCharSet = [NSCharacterSet characterSetWithCharactersInString:@"@!*'()[];:&=+$,/?#"];
	
	NSInteger location = [escapedString rangeOfCharacterFromSet:testIllegalCharSet].location;
	
	STAssertTrue(location == NSNotFound, @"chars in set shouldn't be found");
}

-(void)testURLEscapingPercentString
{
	NSString *testCharString = @"%";
	NSString *escapedString = [testCharString cw_escapeEntitiesForURL];
	
	CWAssertEqualsStrings(escapedString, @"%25");
}

-(void)testEnumerateSubStrings
{    
    NSString *string  = [[NSString alloc] initWithString:@"This\nis\na\nstring\nwith\nmany\nlines."];
    
    __block NSInteger count = 0;
    
    [string cw_enumerateConcurrentlyWithOptions:NSStringEnumerationByLines usingBlock:^(NSString *substring) {
        count++;
    }];
    
    STAssertTrue(count == 7, @"Count should be 7");
}

@end
