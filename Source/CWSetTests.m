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

-(void)testSetFindObjInSet
{
	NSSet *testSet = [NSSet setWithObjects:@"Fry",@"Bender",@"Leela",nil];
	
	id testobj = [testSet cw_find:^(id obj) {
		
		if ([(NSString *)obj isEqualToString:@"Bender"]) {
			return YES;
		}
		
		return NO;
	}];
	
	STAssertNotNil(testobj,@"if obj is nil then cw_find didnt find the bender object");
}

-(void)testSetMapSet
{
	NSSet *testSet1 = [NSSet setWithObjects:@"Fry",@"Bender",@"Leela",nil];
	
	NSSet *testSet2 = [testSet1 cw_map:^(id obj) {
		
		NSString *testString = (NSString *)obj;
		
		return testString;
	}];
	
	STAssertTrue([testSet1 isEqualToSet:testSet2],@"testset1 and testset2 should be equal if using cw_map (NSSet)");
}

@end
