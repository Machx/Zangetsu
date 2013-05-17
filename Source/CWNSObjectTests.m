/*
//  CWNSObjectTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/18/10.
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

#import "CWNSObjectTests.h"
#import "NSObjectAdditions.h"
#import "CWAssertionMacros.h"

SpecBegin(CWNSObject)

describe(@"-cw_associateValue:withKey:", ^{
	it(@"should be able to store & retrieve strong references", ^{
		char *key1 = "key1";
		NSObject *object = [[NSObject alloc] init];
		[object cw_associateValue:@"All Hail the Hypnotoad"
						  withKey:key1];
		
		expect([object cw_valueAssociatedWithKey:key1]).to.equal(@"All Hail the Hypnotoad");
	});
});

describe(@"cw_associateWeakValue:withKey:", ^{
	it(@"should be able to store & retrieve weak references", ^{
		char *key3 = "key3";
		NSObject *object = [[NSObject alloc] init];
		[object cw_associateWeakValue:@"Hypnotoad Season 3"
							  withKey:key3];
		
		expect([object cw_valueAssociatedWithKey:key3]).to.equal(@"Hypnotoad Season 3");
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
