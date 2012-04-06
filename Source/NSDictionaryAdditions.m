/*
//  NSDictionaryAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/12/10.
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

#import "NSDictionaryAdditions.h"


@implementation NSDictionary (CWNSDictionaryAdditions)

/**
 Ruby Inspired Iterator for NSDictionary in Objective-C
 */
-(void)cw_each:(void (^)(id key, id value, BOOL *stop))block 
{
	[self enumerateKeysAndObjectsUsingBlock:block];
}

/**
 Same as cw_each but operates concurrently and passes in a bool
 pointer allowing you to stop the enumeration
 */
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
-(NSDictionary *)cw_mapDictionary:(void (^)(id *key, id *value))block {
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
