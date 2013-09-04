/*
//  NSNumberAdditionsTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 2/24/13.
//
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

#import "NSNumberAdditionsTests.h"
#import "NSNumber+RepeatingActions.h"

SpecBegin(CWNSNumberAdditions)

it(@"should repeatedly execute the block an expected amount of times", ^{
	__block NSUInteger count = 0;
	[@8 cw_times:^(NSInteger index, BOOL *stop) {
		++count;
	}];
	expect(count == 8).to.beTruthy();
});

it(@"should not execute at all when 0", ^{
	__block NSUInteger count = 0;
	[@0 cw_times:^(NSInteger index, BOOL *stop) {
		++count;
	}];
	expect(count == 0).to.beTruthy();
});

it(@"should stop when the stop pointer is set to YES", ^{
	__block NSUInteger count = 0;
	[@30 cw_times:^(NSInteger index, BOOL *stop) {
		++count;
		if (count == 5) *stop = YES;
	}];
	expect(count == 5).to.beTruthy();
});

SpecEnd
