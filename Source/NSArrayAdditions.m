/*
//  NSArrayAdditions.m
//  Zangetsu
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

#if Z_HOST_OS_IS_MAC_OS_X

-(NSHashTable *)cw_findAllIntoWeakRefsWithBlock:(BOOL (^)(id))block {
    NSHashTable * results = [NSHashTable hashTableWithWeakObjects];
	NSIndexSet *indexes = [self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
		return block(obj);
	}];
	[indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
		[results addObject:self[idx]];
	}];
    return results;
}

#endif

-(NSArray *)cw_mapArray:(id (^)(id obj))block {
    NSMutableArray * mappedArray = [NSMutableArray array];
	for (id object in self) {
		id returnedObject = block(object);
        if (returnedObject)
			[mappedArray addObject:returnedObject];
	}
	return mappedArray;
}

-(NSArray *)cw_arrayOfObjectsPassingTest:(BOOL (^)(id obj))block {
	NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
		return block(evaluatedObject);
	}];
	return [self filteredArrayUsingPredicate:predicate];
}

@end
