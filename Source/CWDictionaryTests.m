/*
//  CWDictionaryTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/26/10.
//  Copyright 2010. All rights reserved.
//
 
 Copyright (c) 2013, Colin Wheeler
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 - Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "CWDictionaryTests.h"

SpecBegin(DictionaryTests)

describe(@"-cw_containsKey", ^{
	NSDictionary *dictionary = @{ @"bar" : @"foo" };
	
	it(@"should correctly find a key and return YES", ^{
		expect([dictionary cw_containsKey:@"bar"]).to.beTruthy();
	});
	
	it(@"should correctly return NO for keys not in the dictioanry", ^{
		expect([dictionary cw_containsKey:@"Zapp Brannigan"]).to.beFalsy();
	});
});

describe(@"-cw_mapDictionary", ^{
	it(@"should correctly map a dictionary entries 1-to-1", ^{
		NSDictionary *dictionary = @{ @"bar" : @"foo" };
		
		NSDictionary *results = [dictionary cw_mapDictionary:^NSDictionary *(id key, id value) {
			return @{ key : value };
		}];
		
		expect(results).to.equal(dictionary);
	});
	
	it(@"should not map all entries when nil is returned", ^{
		NSDictionary *dictionary2 = @{ @"Leela" : @"Fry",
								 @"Amy" : @"Kif",
								 @"LaBarbara" : @"Hermes" };
		NSDictionary *results = [dictionary2 cw_mapDictionary:^NSDictionary *(id key, id value) {
			if ([key isEqualToString:@"LaBarbara"]) return nil;
			return @{ key : value };
		}];
		
		expect([results cw_containsKey:@"LaBarbara"]).to.beFalsy();
	});
});

describe(@"-cw_dictionaryByAppendingDictionary", ^{
	it(@"should correctly append one dictionary to another", ^{
		NSDictionary *dict1 = @{ @"key1" : @"value1" };
		NSDictionary *dict2 = @{ @"key2" : @"value2" };
		
		NSDictionary *result = [dict1 cw_dictionaryByAppendingDictionary:dict2];
		
		expect(result.allKeys.count == 2).to.beTruthy();
		expect(result[@"key1"]).to.equal(@"value1");
		expect(result[@"key2"]).to.equal(@"value2");
	});
});

describe(@"-cw_each", ^{
	it(@"should enumerate all key/value pairs in a dictionary", ^{
		NSDictionary *dictionary = @{ @"Futurama" : @"Fry",
								@"Highlander" : @"McCloud" };
		__block NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
		__block int32_t counter = 0;
		[dictionary cw_each:^(id key, id value, BOOL *stop) {
			OSAtomicIncrement32(&counter);
			[results setValue:value
					   forKey:key];
		}];
		
		expect(counter == 2).to.beTruthy();
		expect(results).to.equal(dictionary);
	});
	
	it(@"should stop when *stop is set to YES", ^{
		NSDictionary *dictionary = @{ @"Futurama" : @"Fry",
								@"Highlander" : @"McCloud" };
		__block NSUInteger count = 0;
		[dictionary cw_each:^(id key, id value, BOOL *stop) {
			count++;
			*stop = YES;
		}];
		
		expect(count == 1).to.beTruthy();
	});
});

describe(@"-cw_eachConcurrentlyWithBlock", ^{
	it(@"should enumerate all entries in a dictionary", ^{
		NSDictionary *dictionary = @{ @"Futurama" : @"Fry",
								@"Highlander" : @"McCloud" };
		__block NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
		[dictionary cw_eachConcurrentlyWithBlock:^(id key, id value, BOOL *stop) {
			@synchronized(results) {
				[results setValue:value
						   forKey:key];
			}
		}];
		
		expect(results).to.equal(dictionary);
	});
});

describe(@"-cw_filteredDictionaryOfEntriesPassingTest", ^{
	it(@"should return a new dictionary with only the key/value pairs I expect", ^{
		NSDictionary *dict = @{ @"Futurama" : @"Fry",
						  @"Key2" : @"Bender",
						  @"Key3" : @"Leela",
						  @"Key4" : @"Rodgers",
						  @"Key5" : @"Snake"
	   };
		
		NSDictionary *results = [dict cw_filteredDictionaryOfEntriesPassingTest:^BOOL(id key, id value) {
			if ([key isEqualToString:@"Futurama"] ||
				[value isEqualToString:@"Bender"] ||
				[value isEqualToString:@"Leela"]) {
				return YES;
			}
			return NO;
		}];
		
		NSDictionary *expected = @{ @"Futurama" : @"Fry",
							  @"Key2" : @"Bender",
							  @"Key3" : @"Leela"
							  };
		
		expect(results).to.equal(expected);
	});
});

SpecEnd
