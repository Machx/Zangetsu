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

//TODO: covered all error api's?

SpecBegin(NSErrorTests)

describe(@"CWCreateError()", ^{
	it(@"should create an NSError instance the same as Apples API", ^{
		NSError *error1 = CWCreateError(@"com.something.something",101, @"Some Message");
		NSError *error2 = [NSError errorWithDomain:@"com.something.something"
											  code:101
										  userInfo:@{ NSLocalizedDescriptionKey : @"Some Message" }];
		
		expect(error1.code == error2.code).to.beTruthy();
		expect(error1.domain).to.equal(error2.domain);
		
		NSString *error1Message = [error1 userInfo][NSLocalizedDescriptionKey];
		NSString *error2Message = [error2 userInfo][NSLocalizedDescriptionKey];
		
		expect(error1Message).to.equal(error2Message);
	});
	
	it(@"should accept va args", ^{
		NSError *error = CWCreateError(@"com.something.something", 101, @"Some %@",@"Message");
		NSString *errorMessage = [error userInfo][NSLocalizedDescriptionKey];
		
		expect(errorMessage).to.equal(@"Some Message");
	});
});

describe(@"CWErrorTrap()", ^{
	it(@"should correctly set an NSError object on a NSError pointer", ^{
		NSUInteger i = 50;
		NSError *error;
		BOOL result = CWErrorTrap(i > 5, ^NSError *{
			return CWCreateError(@"com.Test.Test", 404, @"Less than 5");
		}, &error);
		
		expect(result).to.beTruthy();
		expect(error.domain).to.equal(@"com.Test.Test");
		expect(error.code == 404).to.beTruthy();
		expect(error.userInfo[NSLocalizedDescriptionKey]).to.equal(@"Less than 5");
	});
	
	it(@"should return YES condition was meet even when given nil for NSError", ^{
		BOOL result = CWErrorTrap(YES, ^NSError *{
			return nil;
		}, nil);
		
		expect(result).to.beTruthy();
	});
});

SpecEnd
