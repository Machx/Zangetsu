/*
//  NSDictionaryAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/12/10.
//  Copyright 2010. All rights reserved.
//
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
