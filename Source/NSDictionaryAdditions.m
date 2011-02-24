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
 Same as cw_each but operates concurrently and passes in a bool
 pointer allowing you to stop the enumeration
 */
-(NSDictionary *)cw_eachConcurrentlyWithBlock:(void (^)(id key, id value, BOOL *stop))block
{
	dispatch_group_t group = dispatch_group_create();
	
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

	__block BOOL _stop = NO;

	for (id key in self) {

		if(_stop == NO) { break; }

		dispatch_group_async(group, queue, ^{
			block(key,[self valueForKey:key],&_stop);
		});
	}

	dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
	dispatch_release(group);

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
 An dictionary mapping method using only 1 block
 */
-(NSDictionary *)cw_mapDictionary:(void (^)(id *key, id *value))block
{
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	
	__block id _intKey;
	__block id _intValue;
	
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
