/*
//  CWNSErrorTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 3/14/11.
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

#import "CWNSErrorTests.h"
#import "CWErrorUtilities.h"
#import "CWMacros.h"

@implementation CWNSErrorTests

/**
 Testing CWCreateError()
 tests to make sure that the values passed in to each NSError object is the same regardless 
 if a NSError is created with NSError -errorWithDomain:code:... or CWCreateError()
 */
-(void)testCreateError {	
	NSError *error1 = CWCreateError(@"com.something.something",101, @"Some Message");
	
	NSError *error2 = [NSError errorWithDomain:@"com.something.something" code:101 userInfo:NSDICT(@"Some Message",NSLocalizedDescriptionKey)];
	
	STAssertTrue([error1 code] == [error2 code], @"Error 1 and 2 codes should be the same");
	STAssertTrue([[error1 domain] isEqualToString:[error2 domain]], @"Error1 and 2 domains should be the same");
	
	NSString *error1Message = [[error1 userInfo] valueForKey:NSLocalizedDescriptionKey];
	NSString *error2Message = [[error2 userInfo] valueForKey:NSLocalizedDescriptionKey];
	
	STAssertEqualObjects(error1Message, error2Message, @"Error1 and Error2 Message should be the same");
    
    //testing the string format on this NSError method
    NSError *error3 = CWCreateError(@"com.something.something", 101, @"Some %@",@"Message");
    
    NSString *error3Message = [[error3 userInfo] valueForKey:NSLocalizedDescriptionKey];
    
	STAssertEqualObjects(error2Message, error3Message, @"Error Messages should be the same");
}

@end
