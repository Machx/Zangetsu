/*
//  CWNSStringTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/5/10.
//  Copyright 2010. All rights reserved.
//
 
 Copyright (c) 2013, Colin Wheeler
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 - Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "CWNSStringTests.h"
#import <Zangetsu/Zangetsu.h>

SpecBegin(CWNSStringAdditions)

describe(@"-cw_uuidString", ^{
	it(@"should never produce the same thing twice", ^{
		NSString *string1 = [NSString cw_UUIDString];
		NSString *string2 = [NSString cw_UUIDString];
		NSString *string3 = [NSString cw_UUIDString];
		
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
		[string cw_enumerateConcurrentlyWithOptions:NSStringEnumerationByLines withBlock:^(NSString *substring) {
			OSAtomicIncrement32(&count);
		}];
		
		expect(count == 7).to.beTruthy();
	});
});

SpecEnd
