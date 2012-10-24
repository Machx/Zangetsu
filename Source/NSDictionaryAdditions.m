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

-(void)cw_each:(void (^)(id key, id value, BOOL *stop))block 
{
	[self enumerateKeysAndObjectsUsingBlock:block];
}

-(void)cw_eachConcurrentlyWithBlock:(void (^)(id key, id value, BOOL *stop))block
{
	dispatch_group_t group = dispatch_group_create();
	dispatch_queue_t queue = dispatch_queue_create(CWUUIDCStringPrependedWithString(@"com.Zangetsu.NSDictionary_"), DISPATCH_QUEUE_CONCURRENT);
	__block BOOL _stop = NO;

	for (id key in self) {
		if(_stop) { break; }
		dispatch_group_async(group, queue, ^{
			block(key,[self valueForKey:key],&_stop);
		});
	}

	dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
	dispatch_release(group);
	dispatch_release(queue);
}

-(BOOL)cw_dictionaryContainsKey:(NSString *)key
{
	return [[self allKeys] containsObject:key];
}

-(NSDictionary *)cw_mapDictionary:(NSDictionary* (^)(id key, id value))block
{
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	
	[self cw_each:^(id key, id value, BOOL *stop) {
		NSDictionary *returnedDictionary = block(key,value);
		if (returnedDictionary) {
			[dict addEntriesFromDictionary:returnedDictionary];
		}
	}];
	
	return dict;
}

@end
