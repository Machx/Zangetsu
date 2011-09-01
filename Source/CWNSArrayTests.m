/*
//  CWNArrayTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/27/10.
//  Copyright 2010. All rights reserved.
//
 
 Copyright (c) 2011 Colin Wheeler
 
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


@implementation CWNArrayTests

/**
 Testing the cw_fisrtObject method should return the correct object
 */
-(void)testFirstObject
{
	NSArray *testArray = [NSArray arrayWithObjects:@"Fry",@"Leela",@"Bender",nil];
	
	NSString *firstObject = [testArray cw_firstObject];
	
	STAssertTrue([firstObject isEqualToString:@"Fry"],@"First object should be fry for cw_firstObject (NSArray)");
}

/**
 Testing the cw_find api to make sure that inspecting objects works and correctly returns 
 the correct object
 */
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
 Testing the array map method, the 2 arrays should be the same
 */
-(void)testMapArray
{
	NSArray *testArray = [NSArray arrayWithObjects:@"Fry",@"Leela",@"Bender",nil];
	
	NSArray *myArray = [testArray cw_mapArray:^(id obj) {
		
		NSString *string = (NSString *)obj;
		
		return string;
		
	}];
	
	STAssertTrue([testArray isEqualToArray:myArray],@"The 2 arrays should be the same for cw_mapArray");
}

/**
 Testing the each method by using it to map 1 array to another one and then testing 
 to see if the 2 arrays are equal
 */
-(void)testCWEach
{
	NSArray *testArray = [NSArray arrayWithObjects:@"Fry",@"Leela",@"Bender",nil];
	
	__block NSMutableArray *testArray2 = [[NSMutableArray alloc] init];
	
	[testArray cw_each:^(id obj) {
		
		NSString *stringObj = (NSString *)obj;
		
		[testArray2 addObject:stringObj];
	}];
	
	STAssertTrue([testArray isEqualToArray:testArray2],@"TestArray and TestArray 2 should be equal using cw_each");
}

/**
 Testing cw_eachWithIndex by getting the index and then testing the object for the value that
 is supposed to be at that location
 */
-(void)testCWEachWithIndex
{
	NSArray *testArray = [NSArray arrayWithObjects:@"Fry",@"Leela",@"Bender",nil];
	
	[testArray cw_eachWithIndex:^(id obj, NSInteger index) {
		
		NSString *testString = (NSString *)obj;
		
		switch (index) {
			case 0:
				STAssertTrue([testString isEqualToString:@"Fry"],@"Index 0 should be Fry cw_eachWithIndex");
				break;
			case 1:
				STAssertTrue([testString isEqualToString:@"Leela"],@"Index 1 should be Leela cw_eachWithIndex");
				break;
			case 2:
				STAssertTrue([testString isEqualToString:@"Bender"],@"Index 2 should be Bender cw_eachWithIndex");
				break;
			default:
				STAssertTrue(FALSE,@"cw_eachWithIndex should not reach this point");
				break;
		}
	}];
}

-(void)testSelectiveMapping
{
	NSArray *testArray = [NSArray arrayWithObjects:@"Fry",@"Leela",@"Bender",nil];
	
	NSArray *testArray2 = [testArray cw_mapArray:^id(id obj) {
		if([(NSString *)obj isEqualToString:@"Fry"] ||
		   [(NSString *)obj isEqualToString:@"Leela"]){
			return obj;
		}
		
		return nil;
	}];
	
	NSArray *testArray3 = [NSArray arrayWithObjects:@"Fry",@"Leela",nil];
	
	STAssertTrue([testArray2 isEqualToArray:testArray3], @"TestArray2 should equal testArray3");
}

-(void)testEachConcurrently {
	
	NSArray *testArray = [NSArray arrayWithObjects:@"Fry",@"Leela",@"Bender",nil];
	
	__block NSMutableArray *results = [[NSMutableArray alloc] init];
	
	[testArray cw_eachConcurrentlyWithBlock:^(id obj, BOOL *stop) {
		@synchronized(results) {
			[results addObject:obj];
		}
	}];
	
	STAssertTrue([results count] == [testArray count], @"2 arrays should have the same count");
}

-(void)testIsObjectInArrayWithBlock {
	
	NSArray *testArray = [[NSArray alloc] initWithObjects:@"Fry",@"Leela",@"Bender", nil];
	
	BOOL objectIsInArray = [testArray cw_isObjectInArrayWithBlock:^BOOL(id obj) {
		return [(NSString *)obj isEqualToString:@"Bender"];
	}];
	
	STAssertTrue(objectIsInArray, @"Bender should be in the array");
}

-(void)testFindAllWithBlock {
	
	NSArray *testArray = [[NSArray alloc] initWithObjects:@"Fry",@"Leela",@"Bender", nil];
	
	NSArray *resultArray1 = [testArray cw_findAllWithBlock:^BOOL(id obj) {
		if ([(NSString *)obj isEqualToString:@"Fry"] ||
			[(NSString *)obj isEqualToString:@"Leela"]) {
			return YES;
		}
		
		return NO;
	}];
	
	NSArray *resultArray2 = [[NSArray alloc] initWithObjects:@"Fry",@"Leela", nil];
	
	STAssertTrue([resultArray1 isEqualTo:resultArray2], @"arrays should be equal");
}

@end
