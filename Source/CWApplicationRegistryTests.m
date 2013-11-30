/*
//  CWApplicationRegistryTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 6/9/11.
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

#import "CWApplicationRegistry.h"

/**
 These tests are designed to be run inside of Xcode, so its not a bad assumption
 to make that it should be running, otherwise the only other application we could
 test that is guaranteed to be running is Finder
 */

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
	it(@"should not return nil for valid applications", ^{
		expect([CWApplicationRegistry bundleIdentifierForApplication:@"Xcode"]).toNot.beNil();
	});
});

SpecEnd
