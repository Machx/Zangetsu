/*
//  CWNArrayTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/27/10.
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

#import "CWNSArrayTests.h"
#import "CWAssertionMacros.h"

SpecBegin(CWNSArrayTests)

describe(@"-cw_firstObject", ^{
	it(@"should return the correct first object", ^{
		NSArray *testArray = @[ @"Fry",@"Leela",@"Bender" ];
		NSString *firstObject = [testArray cw_firstObject];
		
		expect(firstObject).to.equal(@"Fry");
	});
});

describe(@"-cw_findWithBlock", ^{
	it(@"should find the correct object", ^{
		NSArray *testArray = @[@"Fry",@"Leela",@"Bender"];
		NSString *string = [testArray cw_findWithBlock:^(id obj) {
			if ([(NSString *)obj isEqualToString:@"Bender"]) return YES;
			return NO;
		}];
		expect(string).to.equal(@"Bender");
	});
});

describe(@"-cw_mapArray", ^{
	NSArray *testArray = @[ @"Fry", @"Leela", @"Bender" ];
	
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
	NSArray *testArray = @[ @"Fry", @"Leela", @"Bender" ];
	
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
		NSArray *testArray = @[@"Fry",@"Leela",@"Bender"];
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
		NSArray *testArray = @[@"Fry",@"Leela",@"Bender"];
		BOOL objectIsInArray = [testArray cw_isObjectInArrayWithBlock:^BOOL(id obj) {
			return [(NSString *)obj isEqualToString:@"Bender"];
		}];
		
		expect(objectIsInArray).to.beTruthy();
	});
});

describe(@"-cw_findAllWithBlock", ^{
	it(@"should find all expected objects", ^{
		NSArray *testArray = @[ @"Fry", @"Leela", @"Bender" ];
		NSArray *results = [testArray cw_findAllWithBlock:^BOOL(id obj) {
			if ([(NSString *)obj isEqualToString:@"Fry"] ||
				[(NSString *)obj isEqualToString:@"Leela"]) return YES;
			return NO;
		}];
		NSArray *goodResults = @[ @"Fry", @"Leela" ];
		expect(goodResults).to.equal(results);
	});
});

describe(@"-cw_arrayOfObjectsPassingTest", ^{
	it(@"should find all passing objects", ^{
		NSArray *array = @[ @1, @2, @3, @4, @5, @6, @7, @8, @9, @10 ];
		NSArray *results = [array cw_arrayOfObjectsPassingTest:^BOOL(id obj) {
			return (((NSNumber *)obj).intValue > 5);
		}];
		
		NSArray *goodResults = @[ @6, @7, @8, @9, @10 ];
		
		expect(results).to.haveCountOf(5);
		expect(results).to.equal(goodResults);
	});
});

SpecEnd
