/*
//  CWFoundationTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 6/25/11.
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

#import "CWFoundationTests.h"
#import "CWFoundation.h"
#import "CWMacros.h"

SpecBegin(CWFoundationTests)

describe(@"CWClassExists", ^{
	it(@"should correctly return when classes exist", ^{
		expect(CWClassExists(@"NSString")).to.beTruthy();
	});
	
	it(@"should currectly return when classes don't exist", ^{
		expect(CWClassExists(@"Hypnotoad")).to.beFalsy();
	});
});

describe(@"CWBoolString()", ^{
	it(@"should return a string of 'YES' when passed YES", ^{
		expect(CWBOOLString(YES)).to.equal(@"YES");
	});
	
	it(@"should return a string of 'NO' when passed NO", ^{
		expect(CWBOOLString(NO)).to.equal(@"NO");
	});
	
	it(@"should return a string of 'YES' when given a non nil object", ^{
		expect(CWBOOLString([@"Test" boolValue])).to.equal(@"YES");
	});
	
	it(@"should return a string of 'NO' when given a nil object", ^{
		id obj = nil;
		expect(CWBOOLString([obj boolValue])).to.equal(@"NO");
	});
});

SpecEnd
