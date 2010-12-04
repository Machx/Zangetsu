//
//  NSDictionaryAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/12/10.
//  Copyright 2010. All rights reserved.
//

#import "NSDictionaryAdditions.h"


@implementation NSDictionary (CWNSDictionaryAdditions)

/**
 Ruby Inspired Iterator for NSDictionary in Objective-C
 */
-(NSDictionary *)cw_each:(void (^)(id key, id value))block
{
	for(id key in self) {
		block(key,[self valueForKey:key]);
	}
	
	return self;
}

/**
 Simple Convenience method to tell if the dictionary
 contains a particular key
 */
-(BOOL)cw_dictionaryContainsKey:(NSString *)key
{
	NSArray *keys = [self allKeys];
	
	return [keys containsObject:key];
}

/**
 Dictionary Mapping
 THIS IS VERY EXPERIMENTAL AND IS NOT 100% WORKING AS I WOULD LIKE
 */
-(NSDictionary *)cw_mapDictionary:(void (^)(id *key, id *value))block
{
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	
	id _intKey;
	id _intValue;
	
	for (id key in self.allKeys) {
		
		_intKey = [key copy];
		_intValue = [[self valueForKey:key] copy];
		
		block(&_intKey,&_intValue);
		
		if ( (_intKey != nil) && (_intValue != nil) ) {
			[dict setValue:_intValue forKey:_intKey];
		}
	}
	
	return dict;
}

@end
