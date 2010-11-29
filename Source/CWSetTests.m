//
//  CWSetTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CWSetTests.h"
#import <Zangetsu/Zangetsu.h>

@implementation CWSetTests

/**
 Test for cw_find to make sure it works correctly. It should
 correctly return YES for finding the desired object in the set
 */
-(void)testSetFindObjInSet
{
	NSSet *testSet = [NSSet setWithObjects:@"Fry",@"Bender",@"Leela",nil];
	
	id testobj = [testSet cw_find:^(id obj) {
		
		if ([(NSString *)obj isEqualToString:@"Bender"]) {
			return YES;
		}
		
		return NO;
	}];
	
	STAssertNotNil(testobj,@"if obj is nil then cw_find (NSSet) didnt find the Bender object");
}

/**
 Test for cw_map to make sure it correctly maps to another
 array correctly. In this case it should  do a 1 to 1 map
 of another set and the 2 should equal
 */
-(void)testSetMapSet
{
	NSSet *testSet1 = [NSSet setWithObjects:@"Fry",@"Bender",@"Leela",nil];
	
	NSSet *testSet2 = [testSet1 cw_mapSet:^(id obj) {
		
		NSString *testString = (NSString *)obj;
		
		return testString;
	}];
	
	STAssertTrue([testSet1 isEqualToSet:testSet2],@"testset1 and testset2 should be equal if using cw_map (NSSet)");
}

@end
