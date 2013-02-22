/*
//  CWSetTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/26/10.
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
	it(@"should enumerate all objects in a set", ^{
		NSSet *set1 = NSSET(@"Fry",@"Leeela",@"Bender",@"Nibbler");
		__block NSMutableSet *set2 = [[NSMutableSet alloc] init];
		[set1 cw_eachConcurrentlyWithBlock:^(id obj, BOOL *stop) {
			@synchronized(set2){
				[set2 addObject:obj]; //map set2 1-to-1 with set1
			}
		}];
		
		expect(set2).to.equal(set1);
	});
	
	it(@"should stop enumerating when stop is set to YES", ^{
		NSSet *set1 = NSSET(@"Fry",@"Leeela",@"Bender",@"Nibbler");
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
	NSSet *testSet = [NSSet setWithObjects:@"Fry",@"Bender",@"Leela",nil];
	
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
	NSSet *testSet = [NSSet setWithObjects:@"Fry",@"Bender",@"Leela",nil];
	
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
		NSSet *testSet = [NSSet setWithObjects:@"Fry",@"Bender",@"Leela",nil];
		NSSet *resultSet = [testSet cw_mapSet:^(id obj) {
			return obj;
		}];
		
		expect(resultSet).to.equal(testSet);
	});
	
	it(@"should correctly not map objects to a set", ^{
		NSSet *testSet = [NSSet setWithObjects:@"Fry",@"Bender",@"Leela",nil];
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

describe(@"-cw_findAllWithBlock", ^{
	it(@"should correctly only find objects the block returns YES for", ^{
		NSSet *testSet = [NSSet setWithObjects:@"Fry",@"Bender",@"Leela",nil];
		NSSet *resultSet = [testSet cw_findAllWithBlock:^(id obj) {
			NSString *object = (NSString *)obj;
			if ([object isEqualToString:@"Fry"] ||
				[object isEqualToString:@"Leela"]) {
				return YES;
			}
			return NO;
		}];
		NSSet *goodSet = [NSSet setWithObjects:@"Fry",@"Leela",nil];
		
		expect(resultSet).to.equal(goodSet);
	});
});

SpecEnd
