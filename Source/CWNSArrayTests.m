/*
//  CWNArrayTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/27/10.
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

#import "CWNSArrayTests.h"
#import <Zangetsu/Zangetsu.h>

NSArray *testArray = nil;

SpecBegin(CWNSArrayTests)

beforeAll(^{
	testArray = @[ @"Fry",@"Leela",@"Bender" ];
});

describe(@"-cw_firstObject", ^{
	it(@"should return the correct first object", ^{
		NSString *firstObject = [testArray cw_firstObject];
		expect(firstObject).to.equal(@"Fry");
	});
	
	it(@"should return nil in an empty array", ^{
		NSArray *emptyArray = [[NSArray alloc] init];
		expect([emptyArray cw_firstObject]).to.beNil();
	});
});

describe(@"-cw_randomObject", ^{
	it(@"should return a random object in the array", ^{
		/**
		 Assuming this is truly random this would be really hard to correctly
		 test. This API doesn't mean a unique or different object every time,
		 but generally with enough objects to pick it should give us 2 different
		 random objects in the array.
		 */
		NSArray *randArray = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,
						 @11,@12,@13,@14,@15,@16,@17,@18,@19,@20,
						 @21,@22,@23,@24,@25,@26,@27,@28,@29,@30,
						 @31,@32,@33,@34,@35,@36,@37,@38,@39,@40,
						 @41,@42,@43,@44,@45,@46,@47,@48,@49,@50];
		
		id randObject1 = [randArray cw_randomObject];
		id randObject2 = [randArray cw_randomObject];
		
		expect(randObject1).notTo.equal(randObject2);
	});
});

describe(@"-cw_findWithBlock", ^{
	it(@"should find the correct object", ^{
		NSString *string = [testArray cw_findWithBlock:^(id obj) {
			if ([(NSString *)obj isEqualToString:@"Bender"]) return YES;
			return NO;
		}];
		expect(string).to.equal(@"Bender");
	});
	
	it(@"should return nil if it can't find anything", ^{
		NSString *string = [testArray cw_findWithBlock:^BOOL(id object) {
			if([(NSString *)object isEqualToString:@"Hypnotoad"]) return YES;
			return NO;
		}];
		expect(string).to.beNil();
	});
});

describe(@"-cw_mapArray", ^{
	
	it(@"should map one array to another", ^{
		NSArray *myArray = [testArray cw_mapArray:^(id obj) {
			return obj;
		}];
		expect(myArray).to.equal(testArray);
	});
	
	it(@"should correctly selectively map objects", ^{
		NSArray *results = [testArray cw_mapArray:^id(id obj) {
			if([(NSString *)obj isEqualToString:@"Fry"] ||
			   [(NSString *)obj isEqualToString:@"Leela"]) return obj;
			return nil;
		}];
		NSArray *expectedResults = @[ @"Fry", @"Leela" ];
		expect(results).to.equal(expectedResults);
	});
});


describe(@"-cw_each", ^{
	
	it(@"should enumerate all the objects", ^{
		__block NSMutableArray *results = [[NSMutableArray alloc] init];
		[testArray cw_each:^(id obj, NSUInteger index, BOOL *stop) {
			[results addObject:obj];
		}];
		expect(testArray).to.equal(results);
	});
	
	it(@"should stop when stop is set to YES", ^{
		NSMutableArray *results = [[NSMutableArray alloc] init];
		[testArray cw_each:^(id obj, NSUInteger index, BOOL *stop) {
			[results addObject:obj];
			if ([(NSString *)obj isEqualToString:@"Leela"]) *stop = YES;
		}];
		
		NSArray *goodResults = @[ @"Fry", @"Leela" ];
		expect(results).to.equal(goodResults);
	});
	
	it(@"should have correct indexes for the corresponding objects", ^{
		[testArray cw_each:^(id obj, NSUInteger index, BOOL *stop) {
			if (index == 0) {
				expect(obj).to.equal(@"Fry");
			} else if (index == 1) {
				expect(obj).to.equal(@"Leela");
			} else if (index == 2) {
				expect(obj).to.equal(@"Bender");
			} else {
				STFail(@"cw_eachWithIndex should not reach this point");
			}
		}];
	});
});

describe(@"-cw_eachConcurrently", ^{
	it(@"should enumerate all objects in an array", ^{
		__block int32_t count = 0;
		
		[testArray cw_eachConcurrentlyWithBlock:^(id obj, NSUInteger index, BOOL *stop) {
			OSAtomicIncrement32(&count);
			if (index == 0) {
				expect(obj).to.equal(@"Fry");
			} else if (index == 1) {
				expect(obj).to.equal(@"Leela");
			} else if (index == 2) {
				expect(obj).to.equal(@"Bender");
			}
		}];
		expect(count == 3).to.beTruthy();
	});
});

describe(@"-cw_findObjectWithBlock", ^{
	it(@"should find the object", ^{
		BOOL objectIsInArray = [testArray cw_isObjectInArrayWithBlock:^BOOL(id obj) {
			return [(NSString *)obj isEqualToString:@"Bender"];
		}];
		
		expect(objectIsInArray).to.beTruthy();
	});
	
	it(@"should correctly return NO when an object is not in the array", ^{
		BOOL objectIsInArray = [testArray cw_isObjectInArrayWithBlock:^BOOL(id object) {
			return [(NSString *)object isEqualToString:@"Hypnotoad"];
		}];
		expect(objectIsInArray).to.beFalsy();
	});
});

describe(@"-cw_arrayOfObjectsPassingTest", ^{
	NSArray *array = @[ @1, @2, @3, @4, @5, @6, @7, @8, @9, @10 ];
	
	it(@"should find all passing objects", ^{
		NSArray *results = [array cw_arrayOfObjectsPassingTest:^BOOL(id obj) {
			return (((NSNumber *)obj).intValue > 5);
		}];
		
		NSArray *goodResults = @[ @6, @7, @8, @9, @10 ];
		
		expect(results).to.haveCountOf(5);
		expect(results).to.equal(goodResults);
	});
	
	it(@"should return an empty array when no objects pass", ^{
		NSArray *results = [array cw_arrayOfObjectsPassingTest:^BOOL(id obj) {
			return (((NSNumber *)obj).intValue == 0);
		}];
		
		expect(results).notTo.beNil();
		expect(results.count == 0).to.beTruthy();
	});
});

SpecEnd
