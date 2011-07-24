//
//  CWSetTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/26/10.
//  Copyright 2010. All rights reserved.
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
	
	id testobj = [testSet cw_findWithBlock:^(id obj) {
		
		if ([(NSString *)obj isEqualToString:@"Bender"]) {
			return YES;
		}
		
		return NO;
	}];
	
	STAssertNotNil(testobj,@"if obj is nil then cw_find (NSSet) didnt find the Bender object");
}

/**
 Testing cw_isObjectInSetWithBlock to make sure it returns
 the correct BOOL result
 */
-(void)testIsObjInSet
{
	NSSet *testSet = [NSSet setWithObjects:@"Fry",@"Bender",@"Leela",nil];

	BOOL objInSet = [testSet cw_isObjectInSetWithBlock:^(id obj) {

		return [(NSString *)obj isEqualToString:@"Bender"];
	}];

	STAssertTrue(objInSet,@"Bender should be in the set");
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

-(void)testFindAll
{
	NSSet *testSet1 = [NSSet setWithObjects:@"Fry",@"Bender",@"Leela",nil];
	
	NSSet *testSet2 = [testSet1 cw_findAllWithBlock:^(id obj) {
		NSString *object = (NSString *)obj;
		if ([object isEqualToString:@"Fry"] ||
			[object isEqualToString:@"Leela"]) {
			return YES;
		}
		
		return NO;
	}];
	
	NSSet *testSet3 = [NSSet setWithObjects:@"Fry",@"Leela",nil];
	
	STAssertTrue([testSet2 isEqualToSet:testSet3],@"Sets should be equal");
}

/**
 Test for selective mapping in cw_mapSet.
 */
-(void)testSelectiveMapping;
{
	NSSet *testSet1 = [NSSet setWithObjects:@"Fry",@"Bender",@"Leela",nil];
	
	NSSet *testSet2 = [testSet1 cw_mapSet:^id(id obj) {
		if ([(NSString *)obj isEqualToString:@"Fry"] || 
			[(NSString *)obj isEqualToString:@"Bender"]) {
			return obj;
		}
		
		return nil;
	}];
	
	NSSet *testSet3 = [NSSet setWithObjects:@"Fry",@"Leela",nil];
	
	STAssertFalse([testSet2 isEqualToSet:testSet3], @"TestSet 2 and 3 should be equal in selective mapping");
    
    NSSet *testSet4 = [NSSet setWithObjects:@"Fry",@"Bender", nil];
    
    STAssertTrue([testSet4 isEqualToSet:testSet2], @"The 2 test sets should have equal contents");
}

@end
