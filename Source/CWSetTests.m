/*
//  CWSetTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/26/10.
//  Copyright 2010. All rights reserved.
//
 	*/

#import "CWSetTests.h"
#import <Zangetsu/Zangetsu.h>

SpecBegin(NSSetAdditions)

describe(@"-cw_each", ^{
	NSSet *set1 = NSSET(@"Fry",@"Leeela",@"Bender",@"Nibbler");
	
	it(@"should enumerate all objects", ^{
		__block NSMutableSet *resultSet = [[NSMutableSet alloc] init];
		[set1 cw_each:^(id obj, BOOL *stop) {
			[resultSet addObject:obj];
		}];
		
		expect(resultSet).to.equal(set1);
	});
	
	it(@"should stop enumerating when stop is set to YES", ^{
		__block NSMutableSet *resultSet = [[NSMutableSet alloc] init];
		[set1 cw_each:^(id obj, BOOL *stop) {
			[resultSet addObject:obj];
			*stop = YES;
		}];
		
		expect(resultSet).to.haveCountOf(1);
	});
});

describe(@"-cw_eachConcurrentlyWithBlock", ^{
	NSSet *set1 = NSSET(@"Fry",@"Leeela",@"Bender",@"Nibbler");
	
	it(@"should enumerate all objects in a set", ^{
		__block NSMutableSet *set2 = [[NSMutableSet alloc] init];
		[set1 cw_eachConcurrentlyWithBlock:^(id obj, BOOL *stop) {
			@synchronized(set2){
				[set2 addObject:obj]; //map set2 1-to-1 with set1
			}
		}];
		
		expect(set2).to.equal(set1);
	});
	
	it(@"should stop enumerating when stop is set to YES", ^{
		__block NSMutableSet *set2 = [[NSMutableSet alloc] init];
		[set1 cw_eachConcurrentlyWithBlock:^(id obj, BOOL *stop) {
			@synchronized(set2) {
				if (*stop == NO) {
					[set2 addObject:obj];
					*stop = YES;
				}
			}
		}];
		
		expect(set2).to.haveCountOf(1);
	});
});

<<<<<<< HEAD
/**
 Test for cw_find to make sure it works correctly. It should
 correctly return YES for finding the desired object in the set	*/
-(void)testSetFindObjInSet
{
=======
describe(@"-cw_findWithBlock", ^{
>>>>>>> upstream/master
	NSSet *testSet = [NSSet setWithObjects:@"Fry",@"Bender",@"Leela",nil];
	
	it(@"should correctly find an object in a set", ^{
		id testobj = [testSet cw_findWithBlock:^(id obj) {
			return [(NSString *)obj isEqualToString:@"Bender"];
		}];
		
		expect(testobj).to.equal(@"Bender");
	});
	
	it(@"should return nil when the object is not in a set", ^{
		id testobj = [testSet cw_findWithBlock:^BOOL(id obj) {
			return [(NSString *)obj isEqualToString:@"Foo"];
		}];
		
		expect(testobj).to.beNil();
	});
});

<<<<<<< HEAD
/**
 Testing cw_isObjectInSetWithBlock to make sure it returns
 the correct BOOL result	*/
-(void)testIsObjInSet
{
=======
describe(@"-cw_isObjectInSetWithBlock", ^{
>>>>>>> upstream/master
	NSSet *testSet = [NSSet setWithObjects:@"Fry",@"Bender",@"Leela",nil];
	
	it(@"should correctly return YES if an object is in the set", ^{
		BOOL objInSet = [testSet cw_isObjectInSetWithBlock:^(id obj) {
			return [(NSString *)obj isEqualToString:@"Bender"];
		}];
		
		expect(objInSet).to.beTruthy();
	});
	
	it(@"should correctly return NO if an object is not in the set", ^{
		BOOL objInSet = [testSet cw_isObjectInSetWithBlock:^BOOL(id obj) {
			return [(NSString *)obj isEqualToString:@"Hypnotoad"];
		}];
		
		expect(objInSet).to.beFalsy();
	});
});

<<<<<<< HEAD
/**
 Test for cw_map to make sure it correctly maps to another
 array correctly. In this case it should  do a 1 to 1 map
 of another set and the 2 should equal	*/
-(void)testSetMapSet
{
	NSSet *testSet1 = [NSSet setWithObjects:@"Fry",@"Bender",@"Leela",nil];
	
	NSSet *testSet2 = [testSet1 cw_mapSet:^(id obj) {
		return obj;
	}];
	
	STAssertEqualObjects(testSet1, testSet2, @"testset1 and testset2 should be equal if using cw_map (NSSet)");
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
	
	STAssertEqualObjects(testSet2, testSet3, @"Sets should be equal");
}

/**
 Test for selective mapping in cw_mapSet.	*/
-(void)testSelectiveMapping
{
	NSSet *testSet1 = [NSSet setWithObjects:@"Fry",@"Bender",@"Leela",nil];
	
	NSSet *testSet2 = [testSet1 cw_mapSet:^id(id obj) {
		if ([(NSString *)obj isEqualToString:@"Fry"] || 
			[(NSString *)obj isEqualToString:@"Bender"]) {
=======
describe(@"-cw_mapSet", ^{
	it(@"should corectly map a set 1 to 1", ^{
		NSSet *testSet = [NSSet setWithObjects:@"Fry",@"Bender",@"Leela",nil];
		NSSet *resultSet = [testSet cw_mapSet:^(id obj) {
>>>>>>> upstream/master
			return obj;
		}];
		
		expect(resultSet).to.equal(testSet);
	});
	
	it(@"should correctly not map objects to a set", ^{
		NSSet *testSet = [NSSet setWithObjects:@"Fry",@"Bender",@"Leela",nil];
		NSSet *results = [testSet cw_mapSet:^id(id obj) {
			if ([(NSString *)obj isEqualToString:@"Fry"] ||
				[(NSString *)obj isEqualToString:@"Bender"]) {
				return obj;
			}
			return nil;
		}];
		
		NSSet *goodResults = [NSSet setWithObjects:@"Fry",@"Bender", nil];
		
		expect(results).to.equal(goodResults);
	});
});

SpecEnd
