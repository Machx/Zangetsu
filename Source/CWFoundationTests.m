/*
//  CWFoundationTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 6/25/11.
//  Copyright 2012. All rights reserved.
//
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

SpecEnd
