/*
//  CWDictionaryTests.m
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

#import <Zangetsu/Zangetsu.h>
#import "CWDictionaryTests.h"

@implementation CWDictionaryTests

-(void)testContainsKey {
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

-(void)testDictionaryMapping {
	/**
	 make sure that mapping goes correctly. Again this test does 1-to-1 mapping of
	 1 dictionary from another so if it goes correctly the dictionaries should be identical.
	 */
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"foo",@"bar",nil];
	
	NSDictionary *results = [dictionary cw_mapDictionary:^(id *key,id *value) {
		//*value = @"morvo"; //for testing...
	}];
	
	STAssertEqualObjects(dictionary, results, @"Dictionary and Dictionary2 should be equal");
}

-(void)testEach {
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

-(void)testEachStopPointer {
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

-(void)testEachConcurrent {
	/**
	 make sure that concurrent each is working correctly by mapping a dictionary 
	 and comparing them to make sure that the contents are identical.
	 */
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Fry",@"Futurama",
								@"McCloud",@"Highlander", nil];
	
	__block NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
	
	[dictionary cw_eachConcurrentlyWithBlock:^(id key, id value, BOOL *stop) {
		[results setValue:value forKey:key];
	}];
	
	STAssertEqualObjects(dictionary, results, @"Dictionaries should be the same if enumerated correctly");
}

@end
