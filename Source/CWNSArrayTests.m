//
//  CWNArrayTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/27/10.
//  Copyright 2010. All rights reserved.
//

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
	
	NSString *string = [testArray cw_find:^(id obj) {
		
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
				STAssertTrue([testString isEqualToString:@"Leela"],@"Index 0 should be Fry cw_eachWithIndex");
				break;
			case 2:
				STAssertTrue([testString isEqualToString:@"Bender"],@"Index 0 should be Fry cw_eachWithIndex");
				break;
			default:
				STAssertTrue(FALSE,@"cw_eachWithIndex should not reach this point");
				break;
		}
	}];
}

@end
