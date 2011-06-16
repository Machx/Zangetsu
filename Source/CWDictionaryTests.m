//
//  CWDictionaryTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/26/10.
//  Copyright 2010. All rights reserved.
//

#import <Zangetsu/Zangetsu.h>
#import "CWDictionaryTests.h"

@implementation CWDictionaryTests

/**
 Test for cw_dictionaryContainsKey to make sure it works properly. In this
 case it should return true for finding the object in the dictionary.
 */
-(void)testContainsKey
{
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"foo",@"bar",nil];
	
	STAssertTrue([dictionary cw_dictionaryContainsKey:@"bar"],@"Dictionary should contain key bar");
}

-(void)testDictionaryMapping
{
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"foo",@"bar",nil];
	
	NSDictionary *d2 = [dictionary cw_mapDictionary:^(id *key,id *value) {
		//*value = @"morvo"; //for testing...
	}];
	
	STAssertTrue([dictionary isEqualToDictionary:d2],@"Dictionary and Dictionary2 should be equal");
}

-(void)testEach {
	
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Fry",@"Futurama",
								@"McCloud",@"Highlander", nil];
	
	__block NSMutableDictionary *dictionary2 = [[NSMutableDictionary alloc] init];
	
	[dictionary cw_each:^(id key, id value) {
		[dictionary2 setValue:value forKey:key];
	}];
	
	STAssertTrue([dictionary isEqualToDictionary:dictionary2], @"Dictionaries should be the same");
}

-(void)testEachConcurrent {
	
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Fry",@"Futurama",
								@"McCloud",@"Highlander", nil];
	
	__block NSMutableDictionary *dictionary2 = [[NSMutableDictionary alloc] init];
	
	[dictionary cw_eachConcurrentlyWithBlock:^(id key, id value, BOOL *stop) {
		[dictionary2 setValue:value forKey:key];
	}];
	
	STAssertTrue([dictionary isEqualToDictionary:dictionary2], @"Dictionaries should be the same");
}

@end
