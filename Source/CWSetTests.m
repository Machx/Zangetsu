/*
//  CWSetTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/26/10.
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

#import "CWSetTests.h"
#import <Zangetsu/Zangetsu.h>

@implementation CWSetTests

-(void)testNSSetEach {
	
	NSSet *set1 = NSSET(@"Fry",@"Leeela",@"Bender",@"Nibbler");
	__block NSMutableSet *resultSet = [[NSMutableSet alloc] init];
	
	[set1 cw_each:^(id obj, BOOL *stop) {
		[resultSet addObject:obj];
	}];
	
	STAssertTrue([resultSet isEqualToSet:set1], @"Sets should be equal if enumerated correctly");
}

-(void)testEachStopPointer {
	
	NSSet *set1 = NSSET(@"Fry",@"Leeela",@"Bender",@"Nibbler");
	__block NSMutableSet *resultSet = [[NSMutableSet alloc] init];
	
	[set1 cw_each:^(id obj, BOOL *stop) {
		[resultSet addObject:obj];
		*stop = YES;
	}];
	
	STAssertTrue(([resultSet count] == 1), @"Set should only have 1 object if the stop pointer was respected");
}

-(void)testEachConcurrently {
	NSSet *set1 = NSSET(@"Fry",@"Leeela",@"Bender",@"Nibbler");
	__block NSMutableSet *set2 = [[NSMutableSet alloc] init];
	
	[set1 cw_eachConcurrentlyWithBlock:^(id obj, BOOL *stop) {
		@synchronized(set2){
			[set2 addObject:obj];
		}
	}];
	
	STAssertEqualObjects(set1, set2, @"sets should be equal if enumerated correctly");
}

-(void)testEachConcurrentlyStopPointer {
	
	NSSet *set1 = NSSET(@"Fry",@"Leeela",@"Bender",@"Nibbler");
	__block NSMutableSet *set2 = [[NSMutableSet alloc] init];
	
	[set1 cw_eachConcurrentlyWithBlock:^(id obj, BOOL *stop) {
		@synchronized(set2) {
			if (*stop == NO) {
				[set2 addObject:obj];
				*stop = YES;
			}
		}
	}];
	
	STAssertTrue([set2 count] == 1, @"The set should only have 1 object if the stop pointer was respected");
}

/**
 Test for cw_find to make sure it works correctly. It should
 correctly return YES for finding the desired object in the set
 */
-(void)testSetFindObjInSet {
	NSSet *testSet = [NSSet setWithObjects:@"Fry",@"Bender",@"Leela",nil];
	
	id testobj = [testSet cw_findWithBlock:^(id obj) {
		return [(NSString *)obj isEqualToString:@"Bender"];
	}];
	STAssertNotNil(testobj,@"if obj is nil then cw_find (NSSet) didnt find the Bender object");
	
	id testobj2 = [testSet cw_findWithBlock:^BOOL(id obj) {
		return [(NSString *)obj isEqualToString:@"Foo"];
	}];
	STAssertNil(testobj2, @"should not return an object because Foo should not exist in the set");
}

/**
 Testing cw_isObjectInSetWithBlock to make sure it returns
 the correct BOOL result
 */
-(void)testIsObjInSet {
	NSSet *testSet = [NSSet setWithObjects:@"Fry",@"Bender",@"Leela",nil];

	BOOL objInSet = [testSet cw_isObjectInSetWithBlock:^(id obj) {
		return [(NSString *)obj isEqualToString:@"Bender"];
	}];
	STAssertTrue(objInSet,@"Bender should be in the set");
	
	BOOL obj2InSet = [testSet cw_isObjectInSetWithBlock:^BOOL(id obj) {
		return [(NSString *)obj isEqualToString:@"Hypnotoad"];
	}];
	STAssertFalse(obj2InSet, @"Hypnotoad should not be found in the set");
}

/**
 Test for cw_map to make sure it correctly maps to another
 array correctly. In this case it should  do a 1 to 1 map
 of another set and the 2 should equal
 */
-(void)testSetMapSet {
	NSSet *testSet1 = [NSSet setWithObjects:@"Fry",@"Bender",@"Leela",nil];
	
	NSSet *testSet2 = [testSet1 cw_mapSet:^(id obj) {
		return obj;
	}];
	
	STAssertEqualObjects(testSet1, testSet2, @"testset1 and testset2 should be equal if using cw_map (NSSet)");
}

-(void)testFindAll {
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
	
	STAssertEqualObjects(testSet2, testSet3, @"Sets should be equal");
}

/**
 Test for selective mapping in cw_mapSet.
 */
-(void)testSelectiveMapping; {
	NSSet *testSet1 = [NSSet setWithObjects:@"Fry",@"Bender",@"Leela",nil];
	
	NSSet *testSet2 = [testSet1 cw_mapSet:^id(id obj) {
		if ([(NSString *)obj isEqualToString:@"Fry"] || 
			[(NSString *)obj isEqualToString:@"Bender"]) {
			return obj;
		}
		return nil;
	}];
    
    NSSet *testSet3 = [NSSet setWithObjects:@"Fry",@"Bender", nil];
    
	STAssertEqualObjects(testSet2, testSet3, @"Both sets should have the same contents if cw_mapSet was used right");
}

@end
