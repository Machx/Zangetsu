/*
//  CWNSErrorTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 3/14/11.
//  Copyright 2012. All rights reserved.
//
 
 Copyright (c) 2012 Colin Wheeler
 
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

#import "CWNSErrorTests.h"
#import "CWErrorUtilities.h"
#import "CWMacros.h"
#import "CWAssertionMacros.h"

@implementation CWNSErrorTests

/**
 Testing CWCreateError()
 tests to make sure that the values passed in to each NSError object is the same regardless 
 if a NSError is created with NSError -errorWithDomain:code:... or CWCreateError()
 */
-(void)testCreateError
{	
	NSError *error1 = CWCreateError(@"com.something.something",101, @"Some Message");
	
	NSError *error2 = [NSError errorWithDomain:@"com.something.something" code:101 userInfo:@{ NSLocalizedDescriptionKey : @"Some Message" }];
	
	STAssertTrue([error1 code] == [error2 code], @"Error 1 and 2 codes should be the same");
	CWAssertEqualsStrings(error1.domain, error2.domain);
	
	NSString *error1Message = [[error1 userInfo] valueForKey:NSLocalizedDescriptionKey];
	NSString *error2Message = [[error2 userInfo] valueForKey:NSLocalizedDescriptionKey];
	
	CWAssertEqualsStrings(error1Message, error2Message);
    
    //testing the string format on this NSError method
    NSError *error3 = CWCreateError(@"com.something.something", 101, @"Some %@",@"Message");
    
    NSString *error3Message = [[error3 userInfo] valueForKey:NSLocalizedDescriptionKey];
    
	CWAssertEqualsStrings(error2Message, error3Message);
}

-(void)testCWErrorSet
{
	NSUInteger i = 50;
	NSError *error;
	
	BOOL result = CWErrorTrap(i > 5, ^NSError *{
		return CWCreateError(@"com.Test.Test", 404, @"Less than 5");
	}, &error);
	
	STAssertTrue(result == YES, nil);
	CWAssertEqualsStrings(error.domain, @"com.Test.Test");
	STAssertTrue(error.code == 404, nil);
}

-(void)testCWErrorSetWithNil
{
	BOOL result = CWErrorTrap(YES, ^NSError *{
		return nil;
	}, nil);
	
	STAssertTrue(result == YES, nil);
}

@end
