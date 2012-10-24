/*
//  CWDictionaryTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/26/10.
//  Copyright 2010. All rights reserved.
//
 
 */

#import <Zangetsu/Zangetsu.h>
#import "CWDictionaryTests.h"

@implementation CWDictionaryTests

-(void)testContainsKey
{
	/**
	 Test for cw_dictionaryContainsKey to make sure it works properly. In this
	 case it should return true for finding the object in the dictionary.
	 */
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"foo",@"bar",nil];
	
	STAssertTrue([dictionary cw_dictionaryContainsKey:@"bar"],@"Dictionary should contain key bar");
	
	/**
	 also make sure we correctly detect keys not present in a dictionary
	 */
	STAssertFalse([dictionary cw_dictionaryContainsKey:@"Zapp Brannigan"],@"Dictionary should not contain the key Zapp Brannigan");
}

-(void)testDictionaryMapping
{
	/**
	 make sure that mapping goes correctly. Again this test does 1-to-1 mapping of
	 1 dictionary from another so if it goes correctly the dictionaries should be identical.
	 */
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"foo",@"bar",nil];
	
	NSDictionary *results = [dictionary cw_mapDictionary:^NSDictionary *(id key, id value) {
		return [NSDictionary dictionaryWithObjectsAndKeys:value,key, nil];
	}];
	
	STAssertEqualObjects(dictionary, results, @"Dictionary and Dictionary2 should be equal");
	
	/**
	 We need to make sure that we can exclude key/value pairs from being mapped to the
	 new dictionary so we are going to create 3 key pairs and test to make sure 1 of them
	 isn't being mapped so we know that the mapping method handles nil returns.
	 */
	NSDictionary *dictionary2 = [NSDictionary dictionaryWithObjectsAndKeys:@"Fry",@"Leela",
								 @"Kif",@"Amy",
								 @"Hermes",@"LaBarbara", nil];
	
	NSDictionary *results2 = [dictionary2 cw_mapDictionary:^NSDictionary *(id key, id value) {
		if ([key isEqualToString:@"LaBarbara"]) { return nil; }
		return [NSDictionary dictionaryWithObjectsAndKeys:value,key, nil];
	}];
	
	STAssertFalse([results2 cw_dictionaryContainsKey:@"LaBarbara"],@"Shouldn't contain LaBarbara if mapped correctly");
}

-(void)testEach
{
	/**
	 test cw_each for NSDictionary by enumerating all values in 1 dictioanry &
	 settings those values in another dictionary. If enumeration was done correctly
	 those values should be exactly the same.
	 */
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Fry",@"Futurama",
								@"McCloud",@"Highlander", nil];
	
	__block NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
	
	[dictionary cw_each:^(id key, id value, BOOL *stop) {
		[results setValue:value forKey:key];
	}];
	
	STAssertEqualObjects(dictionary, results, @"Dictionaries should have the same contents if enumerated correctly");
}

-(void)testEachStopPointer
{
	/**
	 make sure the BOOL *stop pointer is respected in cw_each and so we start enumeration
	 & quit immediately after incrementing a counter. If done correclty the counter should
	 only increment once.
	 */
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Fry",@"Futurama",
								@"McCloud",@"Highlander", nil];
	__block NSUInteger count = 0;
	
	[dictionary cw_each:^(id key, id value, BOOL *stop) {
		count++;
		*stop = YES;
	}];
	
	STAssertTrue(count == 1, @"Count should only be 1 if the stop pointer was respected");
}

-(void)testEachConcurrent
{
	/**
	 make sure that concurrent each is working correctly by mapping a dictionary 
	 and comparing them to make sure that the contents are identical.
	 */
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Fry",@"Futurama",
								@"McCloud",@"Highlander", nil];
	
	__block NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
	
	[dictionary cw_eachConcurrentlyWithBlock:^(id key, id value, BOOL *stop) {
		@synchronized(results) {
			[results setValue:value forKey:key];
		}
	}];
	
	STAssertEqualObjects(dictionary, results, @"Dictionaries should be the same if enumerated correctly");
}

@end
