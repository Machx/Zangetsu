/*
//  CWNSObjectTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/18/10.
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

#import "NSObject+Nil.h"

SpecBegin(CWNSObject)

describe(@"-cw_associateValue:atomic:withKey:", ^{
	it(@"should be able to store & retrieve strong references", ^{
		void *key = &key;
		NSObject *object = [NSObject new];
		[object cw_associateValue:@"All Hail the Hypnotoad"
						   atomic:YES
						  withKey:key];
		
		expect([object cw_valueAssociatedWithKey:key]).to.equal(@"All Hail the Hypnotoad");
	});
	
	it(@"should be able to store & retreive strong references nonatomically", ^{
		void *key = &key;
		NSObject *object = [NSObject new];
		[object cw_associateValue:@"Hypnotoad"
						   atomic:NO
						  withKey:key];
		
		expect([object cw_valueAssociatedWithKey:key]).to.equal(@"Hypnotoad");
	});
});

describe(@"-cw_associateValueByCopy:atomic:withKey:", ^{
	it(@"should be able to store & retrieve strong references atomically", ^{
		void *key = &key;
		NSObject *object = [NSObject new];
		[object cw_associateValueByCopyingValue:@"Hypnotoad"
										 atomic:YES
										withKey:key];
		
		expect([object cw_valueAssociatedWithKey:key]).to.equal(@"Hypnotoad");
	});
	
	it(@"should be able to store & retrieve strong references nonatomically", ^{
		void *key = &key;
		NSObject *object = [NSObject new];
		[object cw_associateValueByCopyingValue:@"Hypnotoad"
										 atomic:NO
										withKey:key];
		
		expect([object cw_valueAssociatedWithKey:key]).to.equal(@"Hypnotoad");
	});
});

describe(@"cw_associateWeakValue:withKey:", ^{
	it(@"should be able to store & retrieve weak references", ^{
		void *key = &key;
		NSObject *object = [[NSObject alloc] init];
		[object cw_associateWeakValue:@"Hypnotoad Season 3"
							  withKey:key];
		
		expect([object cw_valueAssociatedWithKey:key]).to.equal(@"Hypnotoad Season 3");
	});
});

describe(@"-cw_isNotNil", ^{
	it(@"should correctly identify non nil references", ^{
		NSString *string = @"今日の天気がいいですね";
		expect([string cw_isNotNil]).to.beTruthy();
	});
	
	it(@"should correctly identify nil reference", ^{
		id object1; //ARC should nil this...
		expect([object1 cw_isNotNil]).to.beFalsy();
	});
});

SpecEnd
