/*
//  NSDictionaryAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/12/10.
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

#import "NSDictionaryAdditions.h"


@implementation NSDictionary (CWNSDictionaryAdditions)

-(void)cw_each:(void (^)(id key, id value, BOOL *stop))block {
	[self enumerateKeysAndObjectsUsingBlock:block];
}

-(void)cw_eachConcurrentlyWithBlock:(void (^)(id key, id value, BOOL *stop))block {
	[self enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent
								  usingBlock:block];
}

-(BOOL)cw_containsKey:(NSString *)key {
	return [[self allKeys] containsObject:key];
}

-(NSDictionary *)cw_dictionaryByAppendingDictionary:(NSDictionary *)dictionary {
	NSMutableDictionary *results = [self mutableCopy];
	[results addEntriesFromDictionary:dictionary];
	return results;
}

-(NSDictionary *)cw_mapDictionary:(NSDictionary* (^)(id key, id value))block {
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	[self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		NSDictionary *returnedDictionary = block(key,obj);
		if (returnedDictionary) [dict addEntriesFromDictionary:returnedDictionary];
	}];
	return dict;
}

-(NSDictionary *)cw_filteredDictionaryOfEntriesPassingTest:(BOOL (^)(id key, id value))block {
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	NSSet *passingKeys = [self keysOfEntriesPassingTest:^BOOL(id key, id obj, BOOL *stop) {
		return block(key,obj);
	}];
	[passingKeys enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
		[dictionary addEntriesFromDictionary:@{obj : self[obj]}];
	}];
	return dictionary;
}

@end
