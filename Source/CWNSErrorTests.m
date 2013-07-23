/*
//  CWNSErrorTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 3/14/11.
//  Copyright 2012. All rights reserved.
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

#import "CWNSErrorTests.h"
#import "CWErrorUtilities.h"

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

describe(@"CWCreateErrorWithUserInfo()", ^{
	it(@"should store values that can be retrieved in the info dictionary", ^{
		NSError *error = CWCreateErrorWithUserInfo(@"com.something.something",
												   404,
												   @{ @"testKey" : @"Hypnotoad" },
												   @"I can't computer!");
		
		expect(error.userInfo[@"testKey"]).to.equal(@"Hypnotoad");
	});
});

SpecEnd
