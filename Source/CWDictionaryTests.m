//
//  CWDictionaryTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
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
	
	NSDictionary *d2 = [dictionary cw_mapDictionary:^(id *value, id *key) {
		//
	}];
	
	NSLog(@"dict %@\ndict2 %@",dictionary,d2);
	
	STAssertTrue([dictionary isEqualToDictionary:d2],@"Dictionary and Dictionary2 should be equal");
}

@end
