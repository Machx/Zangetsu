/*
//  NSSetAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/15/10.
//  Copyright 2010. All rights reserved.
//
 
 Copyright (c) 2012 Colin Wheeler
 
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

-(void)cw_each:(void (^)(id obj, BOOL *stop))block {
	[self enumerateObjectsUsingBlock:block];
}

-(void)cw_eachConcurrentlyWithBlock:(void (^)(id obj,BOOL *stop))block {
	[self enumerateObjectsWithOptions:NSEnumerationConcurrent
						   usingBlock:block];
}

-(id)cw_findWithBlock:(BOOL (^)(id obj))block {
	for(id obj in self){
		if(block(obj)) return obj;
	}
	return nil;
}

-(BOOL)cw_isObjectInSetWithBlock:(BOOL (^)(id obj))block {
	return ([self cw_findWithBlock:block] ? YES : NO);
}

#if Z_HOST_OS_IS_MAC_OS_X
-(NSHashTable *)cw_findAllIntoWeakRefsWithBlock:(BOOL (^)(id))block {
	NSHashTable *results = [NSHashTable hashTableWithWeakObjects];
	[self cw_each:^(id obj, BOOL *stop) {
		if (block(obj)) [results addObject:obj];
	}];
	return results;
}
#endif

-(NSSet *)cw_mapSet:(id (^)(id obj))block {
	NSMutableSet *mappedSet = [[NSMutableSet alloc] init];
	[self cw_each:^(id obj, BOOL *stop) {
		id rObj = block(obj);
		if (rObj) [mappedSet addObject:rObj];
	}];
    return mappedSet;
}

-(NSSet *)cw_setOfObjectsPassingTest:(BOOL (^)(id obj))block {
	NSMutableSet *set = [NSMutableSet set];
	[self cw_each:^(id obj, BOOL *stop) {
		if (block(obj)) [set addObject:obj];
	}];
	return set;
}

@end
