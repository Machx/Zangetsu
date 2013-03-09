/*
//  NSArrayAdditions.m
//  Zangetsu
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

#import "NSArrayAdditions.h"


@implementation NSArray (CWNSArrayAdditions)

-(id)cw_firstObject {
	return (self.count > 0 ? self[0] : nil);
}

-(void)cw_each:(void (^)(id obj, NSUInteger index, BOOL *stop))block {
	[self enumerateObjectsUsingBlock:block];
}

-(void)cw_eachConcurrentlyWithBlock:(void (^)(id obj, NSUInteger index, BOOL * stop))block {
	[self enumerateObjectsWithOptions:NSEnumerationConcurrent
						   usingBlock:block];
}

-(id)cw_findWithBlock:(BOOL (^)(id obj))block {
	NSUInteger index = [self indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
		if (block(obj)) {
			return YES;
			*stop = YES;
		}
		return NO;
	}];
	return (index != NSNotFound ? self[index] : nil);
}

-(BOOL)cw_isObjectInArrayWithBlock:(BOOL (^)(id obj))block {
	NSUInteger index = [self indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
		return (block(obj) ? YES : NO);
	}];
	return (index != NSNotFound ? YES : NO);
}

-(NSArray *)cw_findAllWithBlock:(BOOL (^)(id obj))block {
	NSIndexSet *indexes = [self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
		return (block(obj) ? YES : NO);
	}];
	if (indexes.count > 0) {
		NSMutableArray *results = [NSMutableArray array];
		[indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
			[results addObject:self[idx]];
		}];
		return results;
	}
	return nil;
}

#if Z_HOST_OS_IS_MAC_OS_X

-(NSHashTable *)cw_findAllIntoWeakRefsWithBlock:(BOOL (^)(id))block {
    NSHashTable * results = [NSHashTable hashTableWithWeakObjects];
    [self cw_each:^(id obj, NSUInteger index, BOOL *stop) {
		if (block(obj)) [results addObject:obj];
	}];
    return results;
}

#endif

-(NSArray *)cw_mapArray:(id (^)(id obj))block {
    NSMutableArray * cwArray = [NSMutableArray array];
	[self cw_each:^(id obj, NSUInteger index, BOOL *stop) {
		id rObj = block(obj);
        if (rObj) [cwArray addObject:rObj];
	}];
	return cwArray;
}

-(NSArray *)cw_arrayOfObjectsPassingTest:(BOOL (^)(id obj))block {
	NSMutableArray *array = [NSMutableArray array];
	[self cw_each:^(id object, NSUInteger index, BOOL *stop) {
		if (block(object)) [array addObject:object];
	}];
	return array;
}

@end
