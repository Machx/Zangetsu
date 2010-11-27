//
//  CWNArrayTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/27/10.
//  Copyright 2010. All rights reserved.
//

#import "CWNSArrayTests.h"


@implementation CWNArrayTests

-(void)testFirstObject
{
	NSArray *testArray = [NSArray arrayWithObjects:@"Fry",@"Leela",@"Bender",nil];
	
	NSString *firstObject = [testArray cw_firstObject];
	
	STAssertTrue([firstObject isEqualToString:@"Fry"],@"First object should be fry for cw_firstObject (NSArray)");
}

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

-(void)testMapArray
{
	NSArray *testArray = [NSArray arrayWithObjects:@"Fry",@"Leela",@"Bender",nil];
	
	NSArray *myArray = [testArray cw_mapArray:^(id obj) {
		
		NSString *string = (NSString *)obj;
		
		return string;
		
	}];
	
	STAssertTrue([testArray isEqualToArray:myArray],@"The 2 arrays should be the same for cw_mapArray");
}

@end
