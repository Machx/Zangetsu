/*
//  CWNArrayTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/27/10.
//  Copyright 2010. All rights reserved.
//
<<<<<<< HEAD
 	*/
 
=======
 
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

>>>>>>> upstream/master
#import "CWNSArrayTests.h"
#import "CWAssertionMacros.h"

NSArray *testArray = nil;

<<<<<<< HEAD
@implementation CWNArrayTests

/**
 Testing the cw_fisrtObject method should return the correct object	*/
-(void)testFirstObject
{
	NSArray *testArray = [NSArray arrayWithObjects:@"Fry",@"Leela",@"Bender",nil];
	NSString *firstObject = [testArray cw_firstObject];
	
	CWAssertEqualsStrings(firstObject, @"Fry");
}

/**
 Testing the cw_find api to make sure that inspecting objects works and correctly returns 
 the correct object	*/
-(void)testFind
{
	NSArray *testArray = [NSArray arrayWithObjects:@"Fry",@"Leela",@"Bender",nil];
	
	NSString *string = [testArray cw_findWithBlock:^(id obj) {
		if ([(NSString *)obj isEqualToString:@"Bender"]) {
			return YES;
		}
		return NO;
	}];
	
	STAssertNotNil(string,@"String should not be nil because the string 'Bender' should be found in the array");
}

/**
 Testing the array map method, the 2 arrays should be the same	*/
-(void)testMapArray
{
	NSArray *testArray = [NSArray arrayWithObjects:@"Fry",@"Leela",@"Bender",nil];
	
	NSArray *myArray = [testArray cw_mapArray:^(id obj) {
		return obj;
	}];
	
	STAssertEqualObjects(testArray, myArray, @"The 2 arrays should be the same for cw_mapArray");
}

/**
 Testing the each method by using it to map 1 array to another one and then testing 
 to see if the 2 arrays are equal	*/
-(void)testCWEach
{
	NSArray *testArray = [NSArray arrayWithObjects:@"Fry",@"Leela",@"Bender",nil];
	
	__block NSMutableArray *results = [[NSMutableArray alloc] init];
	
	[testArray cw_each:^(id obj, NSUInteger index, BOOL *stop) {
		[results addObject:obj];
	}];
	
	STAssertEqualObjects(testArray, results, @"TestArray and TestArray 2 should be equal using cw_each");
}

/**
 tests to make sure that the stop pointer in the cw_each method is respected
 
 in this exercise we have an item with 3 elements and 	*/
-(void)testEachStopPointer
{
	NSArray *testArray = [NSArray arrayWithObjects:@"Fry",@"Leela",@"Bender",nil];
	NSMutableArray *results = [[NSMutableArray alloc] init];
	
	[testArray cw_each:^(id obj, NSUInteger index, BOOL *stop) {
		[results addObject:obj];
		if ([(NSString *)obj isEqualToString:@"Leela"]) { *stop = YES; }
	}];
	
	NSArray *goodResults = [NSArray arrayWithObjects:@"Fry",@"Leela", nil];
	
	STAssertEqualObjects(goodResults, results, @"Arrays should be equal if the stop pointer was respected");
}

/**
 Testing cw_eachWithIndex by getting the index and then testing the object for the value that
 is supposed to be at that location	*/
-(void)testCWEachIndex
{
	NSArray *testArray = [NSArray arrayWithObjects:@"Fry",@"Leela",@"Bender",nil];
	
	[testArray cw_each:^(id obj, NSUInteger index, BOOL *stop) {
		switch (index) {
			case 0:
				CWAssertEqualsStrings(obj, @"Fry");
				break;
			case 1:
				CWAssertEqualsStrings(obj, @"Leela");
				break;
			case 2:
				CWAssertEqualsStrings(obj, @"Bender");
				break;
			default:
				STAssertTrue(0,@"cw_eachWithIndex should not reach this point");
				break;
		}
	}];
}
=======
SpecBegin(CWNSArrayTests)

beforeAll(^{
	testArray = @[ @"Fry",@"Leela",@"Bender" ];
});

describe(@"-cw_firstObject", ^{
	it(@"should return the correct first object", ^{
		NSString *firstObject = [testArray cw_firstObject];
		
		expect(firstObject).to.equal(@"Fry");
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
});
>>>>>>> upstream/master

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
