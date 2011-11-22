/*
//  NSSetAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/15/10.
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

#import "NSSetAdditions.h"


@implementation NSSet (CWNSSetAdditions)

/**
 Ruby inspired iterator
 */
-(void)cw_each:(void (^)(id obj, BOOL *stop))block {
	if ((self == nil) || ([self count] == 0)) { return; }
	
	__block BOOL stop = NO;
	
	for (id obj in self) {
		if(stop == YES) { break; }
		block(obj,&stop);
	}
}

/**
 Experimental each method that runs concurrently
 */
-(void)cw_eachConcurrentlyWithBlock:(void (^)(id obj,BOOL *stop))block {
	if ((self == nil) || ([self count] == 0)) { return; }
	
	dispatch_group_t group = dispatch_group_create();
	dispatch_queue_t queue = dispatch_queue_create("com.zangetsu.nssetadditions_conncurrenteach", 0);
	__block BOOL _stop = NO;

	for(id object in self){

		if (_stop == YES) { break; }

		dispatch_group_async(group, queue, ^{
			block(object,&_stop);
		});
	}

	dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
	dispatch_release(group);
	dispatch_release(queue);
}


/**
 Simple convenience method to find a object in
 a NSSet using a block
 */
-(id)cw_findWithBlock:(BOOL (^)(id obj))block {
	if ((self == nil) || ([self count] == 0)) { return nil; }
	
	for(id obj in self){
		if(block(obj)){
			return obj;
		}
	}
	
	return nil;
}

/**
 Exactly like cw_findWithBlock except it returns a BOOL
 */
-(BOOL)cw_isObjectInSetWithBlock:(BOOL (^)(id obj))block {
	if ((self == nil) || ([self count] == 0)) { return NO; }
	
	for (id obj in self) {
		if (block(obj)) {
			return YES;
		}
	}
	
	return NO;
}

/**
 like cw_find but instead uses NSArray to store 
 all objects passing the test of the bool block
 */
-(NSSet *)cw_findAllWithBlock:(BOOL (^)(id obj))block {
	if ((self == nil) || ([self count] == 0)) { return nil; }
	
	NSMutableSet *results = [[NSMutableSet alloc] init];
	
	for (id obj in self) {
		if (block(obj)) {
			[results addObject:obj];
		}
	}
	
	return results;
}

/**
 experimental method
 like cw_find but instead uses NSHashTable to store pointers to 
 all objects passing the test of the bool block
 */
-(NSHashTable *)cw_findAllIntoWeakRefsWithBlock:(BOOL (^)(id))block {
	if ((self == nil) || ([self count] == 0)) { return nil; }
	
	NSHashTable *results = [NSHashTable hashTableWithWeakObjects];
	
	for (id obj in self) {
		if (block(obj)) {
			[results addObject:obj];
		}
	}

	return results;
}

/**
 cw_mapSet basically maps a set by enumerating
 over the set to be mapped and executes the block while
 passing in the object to map. You simply need to either
 (1) return the object to be mapped in the new set or
 (2) return nil if you don't want to map the passed in object
 
 @param block a block returning the object to be mapped or nil if no object is to be mapped
 @return a NSSet of objects that have been mapped from an original NSSet
 */
-(NSSet *)cw_mapSet:(id (^)(id obj))block {
	if ((self == nil) || ([self count] == 0)) { return nil; }
	
	NSMutableSet *cwArray = [[NSMutableSet alloc] init];

    for (id obj in self) {
        id rObj = block(obj);
        if(rObj){
            [cwArray addObject:rObj];
        }
    }

    return cwArray;
}

@end
