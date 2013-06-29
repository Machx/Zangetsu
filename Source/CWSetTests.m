/*
//  CWSetTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/26/10.
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

#import "CWSetTests.h"
#import <Zangetsu/Zangetsu.h>

SpecBegin(NSSetAdditions)

describe(@"-cw_each", ^{
	NSSet *set1 = NSSET(@"Fry",@"Leeela",@"Bender",@"Nibbler");
	
	it(@"should enumerate all objects", ^{
		__block NSMutableSet *resultSet = [[NSMutableSet alloc] init];
		[set1 cw_each:^(id obj, BOOL *stop) {
			[resultSet addObject:obj];
		}];
		
		expect(resultSet).to.equal(set1);
	});
	
	it(@"should stop enumerating when stop is set to YES", ^{
		__block NSMutableSet *resultSet = [[NSMutableSet alloc] init];
		[set1 cw_each:^(id obj, BOOL *stop) {
			[resultSet addObject:obj];
			*stop = YES;
		}];
		
		expect(resultSet).to.haveCountOf(1);
	});
});

describe(@"-cw_eachConcurrentlyWithBlock", ^{
	NSSet *set1 = NSSET(@"Fry",@"Leeela",@"Bender",@"Nibbler");
	
	it(@"should enumerate all objects in a set", ^{
		__block NSMutableSet *set2 = [[NSMutableSet alloc] init];
		[set1 cw_eachConcurrentlyWithBlock:^(id obj, BOOL *stop) {
			@synchronized(set2){
				[set2 addObject:obj]; //map set2 1-to-1 with set1
			}
		}];
		
		expect(set2).to.equal(set1);
	});
	
	it(@"should stop enumerating when stop is set to YES", ^{
		__block NSMutableSet *set2 = [[NSMutableSet alloc] init];
		[set1 cw_eachConcurrentlyWithBlock:^(id obj, BOOL *stop) {
			@synchronized(set2) {
				if (*stop == NO) {
					[set2 addObject:obj];
					*stop = YES;
				}
			}
		}];
		
		expect(set2).to.haveCountOf(1);
	});
});

describe(@"-cw_findWithBlock", ^{
	NSSet *testSet = NSSET(@"Fry",@"Bender",@"Leela");
	
	it(@"should correctly find an object in a set", ^{
		id testobj = [testSet cw_findWithBlock:^(id obj) {
			return [(NSString *)obj isEqualToString:@"Bender"];
		}];
		
		expect(testobj).to.equal(@"Bender");
	});
	
	it(@"should return nil when the object is not in a set", ^{
		id testobj = [testSet cw_findWithBlock:^BOOL(id obj) {
			return [(NSString *)obj isEqualToString:@"Foo"];
		}];
		
		expect(testobj).to.beNil();
	});
});

describe(@"-cw_isObjectInSetWithBlock", ^{
	NSSet *testSet = NSSET(@"Fry",@"Bender",@"Leela");
	
	it(@"should correctly return YES if an object is in the set", ^{
		BOOL objInSet = [testSet cw_isObjectInSetWithBlock:^(id obj) {
			return [(NSString *)obj isEqualToString:@"Bender"];
		}];
		
		expect(objInSet).to.beTruthy();
	});
	
	it(@"should correctly return NO if an object is not in the set", ^{
		BOOL objInSet = [testSet cw_isObjectInSetWithBlock:^BOOL(id obj) {
			return [(NSString *)obj isEqualToString:@"Hypnotoad"];
		}];
		
		expect(objInSet).to.beFalsy();
	});
});

describe(@"-cw_mapSet", ^{
	it(@"should corectly map a set 1 to 1", ^{
		NSSet *testSet = NSSET(@"Fry",@"Bender",@"Leela");
		NSSet *resultSet = [testSet cw_mapSet:^(id obj) {
			return obj;
		}];
		
		expect(resultSet).to.equal(testSet);
	});
	
	it(@"should correctly not map objects to a set", ^{
		NSSet *testSet = NSSET(@"Fry",@"Bender",@"Leela");
		NSSet *results = [testSet cw_mapSet:^id(id obj) {
			if ([(NSString *)obj isEqualToString:@"Fry"] ||
				[(NSString *)obj isEqualToString:@"Bender"]) {
				return obj;
			}
			return nil;
		}];
		
		NSSet *goodResults = [NSSet setWithObjects:@"Fry",@"Bender", nil];
		
		expect(results).to.equal(goodResults);
	});
});

SpecEnd
