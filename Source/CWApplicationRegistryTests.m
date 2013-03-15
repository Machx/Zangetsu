/*
//  CWApplicationRegistryTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 6/9/11.
//  Copyright 2012. All rights reserved.
//
 	*/

#import "CWApplicationRegistryTests.h"
#import "CWApplicationRegistry.h"

/**
 These tests are designed to be run inside of Xcode, so its not a bad assumption
 to make that it should be running, otherwise the only other application we could
 test that is guaranteed to be running is Finder	*/

SpecBegin(CWApplicationRegistry)

describe(@"+applicationIsrunning", ^{
	it(@"should correctly identify when an app is running", ^{
		expect([CWApplicationRegistry applicationIsRunning:@"Xcode"]).to.beTruthy();
	});
	
	it(@"should correctly identify when an app is not running", ^{
		//seriously don't ever ship an app named this
		expect([CWApplicationRegistry applicationIsRunning:@"Hypnotoad3333455443333"]).to.beFalsy();
	});
});

describe(@"+bundleIdentifierForApplicaton", ^{
	it(@"should no return nil for valid applications", ^{
		expect([CWApplicationRegistry bundleIdentifierForApplication:@"Xcode"]).toNot.beNil();
	});
});

SpecEnd
