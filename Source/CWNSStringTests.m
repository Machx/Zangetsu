/*
//  CWNSStringTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/5/10.
//  Copyright 2010. All rights reserved.
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

#import "CWNSStringTests.h"
#import <Zangetsu/Zangetsu.h>

SpecBegin(CWNSStringAdditions)

describe(@"-cw_uuidString", ^{
	it(@"should never produce the same thing twice", ^{
		NSString *string1 = [NSString cw_uuidString];
		NSString *string2 = [NSString cw_uuidString];
		NSString *string3 = [NSString cw_uuidString];
		
		expect(string1).notTo.equal(string2);
		expect(string1).notTo.equal(string3);
		expect(string2).notTo.equal(string3);
	});
});

describe(@"-cw_isNotEmptyString", ^{
	it(@"should correctly detect an empty string", ^{
		NSString *emptyString = @"";
		expect([emptyString cw_isNotEmptyString]).to.beFalsy();
	});
	
	it(@"should correctly detect non empty strings", ^{
		NSString *testString = @"Fry";
		expect([testString cw_isNotEmptyString]).to.beTruthy();
	});
});

describe(@"-cw_escapeEntitiesForURL", ^{
	it(@"should escape all illegal characters", ^{
		NSString *urlCharsString = @"@!*'()[];:&=+$,/?%#";
		NSString *escapedString = [urlCharsString cw_escapeEntitiesForURL];
		NSCharacterSet *testIllegalCharSet = [NSCharacterSet characterSetWithCharactersInString:@"@!*'()[];:&=+$,/?#"];
		NSInteger location = [escapedString rangeOfCharacterFromSet:testIllegalCharSet].location;
		
		expect(location == NSNotFound).to.beTruthy();
	});
	
	it(@"should escape percent strings", ^{
		NSString *testCharString = @"%";
		NSString *escapedString = [testCharString cw_escapeEntitiesForURL];
		
		expect(escapedString).to.equal(@"%25");
	});
});

describe(@"-cw_enumerateConcurrentlyWithOptions:usingBlock:", ^{
	it(@"should enumerate all substrings", ^{
		NSString *string  = @"This\nis\na\nstring\nwith\nmany\nlines.";
		__block int32_t count = 0;
		[string cw_enumerateConcurrentlyWithOptions:NSStringEnumerationByLines usingBlock:^(NSString *substring) {
			OSAtomicIncrement32(&count);
		}];
		
		expect(count == 7).to.beTruthy();
	});
});

SpecEnd
