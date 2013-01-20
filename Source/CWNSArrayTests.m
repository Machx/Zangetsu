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


@implementation CWNArrayTests

/**
 Testing the cw_fisrtObject method should return the correct object
 */
-(void)testFirstObject
{
	NSArray *testArray = @[@"Fry",@"Leela",@"Bender"];
	NSString *firstObject = [testArray cw_firstObject];
	
	CWAssertEqualsStrings(firstObject, @"Fry");
}

/**
 Testing the cw_find api to make sure that inspecting objects works and correctly returns 
 the correct object
 */
-(void)testFind
{
	NSArray *testArray = @[@"Fry",@"Leela",@"Bender"];
	
	NSString *string = [testArray cw_findWithBlock:^(id obj) {
		if ([(NSString *)obj isEqualToString:@"Bender"]) {
			return YES;
		}
		return NO;
	}];
	
	STAssertNotNil(string,@"String should not be nil because the string 'Bender' should be found in the array");
}

/**
 Testing the array map method, the 2 arrays should be the same
 */
-(void)testMapArray
{
	NSArray *testArray = @[@"Fry",@"Leela",@"Bender"];
	
	NSArray *myArray = [testArray cw_mapArray:^(id obj) {
		return obj;
	}];
	
	STAssertEqualObjects(testArray, myArray, @"The 2 arrays should be the same for cw_mapArray");
}

/**
 Testing the each method by using it to map 1 array to another one and then testing 
 to see if the 2 arrays are equal
 */
-(void)testCWEach
{
	NSArray *testArray = @[@"Fry",@"Leela",@"Bender"];
	
	__block NSMutableArray *results = [[NSMutableArray alloc] init];
	
	[testArray cw_each:^(id obj, NSUInteger index, BOOL *stop) {
		[results addObject:obj];
	}];
	
	STAssertEqualObjects(testArray, results, @"TestArray and TestArray 2 should be equal using cw_each");
}

/**
 tests to make sure that the stop pointer in the cw_each method is respected
 
 in this exercise we have an item with 3 elements and 
 */
-(void)testEachStopPointer
{
	NSArray *testArray = @[@"Fry",@"Leela",@"Bender"];
	NSMutableArray *results = [[NSMutableArray alloc] init];
	
	[testArray cw_each:^(id obj, NSUInteger index, BOOL *stop) {
		[results addObject:obj];
		if ([(NSString *)obj isEqualToString:@"Leela"]) { *stop = YES; }
	}];
	
	NSArray *goodResults = @[@"Fry",@"Leela"];
	
	STAssertEqualObjects(goodResults, results, @"Arrays should be equal if the stop pointer was respected");
}

/**
 Testing cw_eachWithIndex by getting the index and then testing the object for the value that
 is supposed to be at that location
 */
-(void)testCWEachIndex
{
	NSArray *testArray = @[@"Fry",@"Leela",@"Bender"];
	
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

-(void)testSelectiveMapping
{
	NSArray *testArray = @[@"Fry",@"Leela",@"Bender"];
	
	NSArray *testArray2 = [testArray cw_mapArray:^id(id obj) {
		if([(NSString *)obj isEqualToString:@"Fry"] ||
		   [(NSString *)obj isEqualToString:@"Leela"]){
			return obj;
		}
		return nil;
	}];
	
	NSArray *expectedResults = @[@"Fry",@"Leela"];
	STAssertEqualObjects(testArray2, expectedResults, @"The 2 arrays should be equal if mapped correctly");
}

-(void)testEachConcurrently
{
	/**
	 Tests the API cw_eachConcurrentlyWithBlock. In this test we are making sure
	 that all objects are enumerated over and thus our original array and results
	 array should have the same contents. We then enumerate over the original array
	 and make sure that the objects have the correct indexes passed in the block.
	 */
	
	NSArray *testArray = @[@"Fry",@"Leela",@"Bender"];
	
	__block int32_t count = 0;
	
	[testArray cw_eachConcurrentlyWithBlock:^(id obj, NSUInteger index, BOOL *stop) {
		OSAtomicIncrement32(&count);
	}];
	
	STAssertTrue(count == 3,@"count should be 3");
    
    [testArray cw_eachConcurrentlyWithBlock:^(id obj, NSUInteger index, BOOL *stop) {
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
				STAssertTrue(0,@"should not reach this point");
				break;
        }
    }];
}

-(void)testIsObjectInArrayWithBlock
{
	/**
	 tests the cw_isObjectInArrayWithBlock API. The API simply returns a BOOL 
	 indicating if the object is in the array. This test should always return
	 YES because we know the object is in the array.
	 */
	
	NSArray *testArray = @[@"Fry",@"Leela",@"Bender"];
	
	BOOL objectIsInArray = [testArray cw_isObjectInArrayWithBlock:^BOOL(id obj) {
		return [(NSString *)obj isEqualToString:@"Bender"];
	}];
	
	STAssertTrue(objectIsInArray, @"Bender should be in the array");
}

-(void)testFindAllWithBlock
{
	/**
	 Testing the cw_findAllWithBlock api. This should find all ojbects we are looking 
	 for in an array and then compare it to another array that has the objects we 
	 know the api should return. If the 2 arrays are the same the API works as desired...
	 */
	
	NSArray *testArray = @[@"Fry",@"Leela",@"Bender"];
	
	NSArray *resultArray1 = [testArray cw_findAllWithBlock:^BOOL(id obj) {
		if ([(NSString *)obj isEqualToString:@"Fry"] ||
			[(NSString *)obj isEqualToString:@"Leela"]) {
			return YES;
		}
		return NO;
	}];
	
	NSArray *goodResults = @[@"Fry",@"Leela"];
	STAssertEqualObjects(resultArray1, goodResults, @"Arrays should be equal if all objects were found");
}

-(void)testObjectsPassingTest
{
	NSArray *array = @[ @1, @2, @3, @4, @5, @6, @7, @8, @9, @10 ];
	
	NSArray *results = [array cw_arrayOfObjectsPassingTest:^BOOL(id obj) {
		return ( [(NSNumber *)obj intValue] > 5 );
	}];
	
	STAssertTrue(results.count == 5, nil);
	[results cw_each:^(id object, NSUInteger index, BOOL *stop) {
		NSNumber *number = (NSNumber *)object;
		switch (index) {
			case 0:
				STAssertTrue(number.intValue == 6, nil);
				break;
			case 1:
				STAssertTrue(number.intValue == 7, nil);
				break;
			case 2:
				STAssertTrue(number.intValue == 8, nil);
				break;
			case 3:
				STAssertTrue(number.intValue == 9, nil);
				break;
			case 4:
				STAssertTrue(number.intValue == 10, nil);
				break;
			default:
				STFail(@"Enumerated past expected array range");
				break;
		}
	}];
}

@end
