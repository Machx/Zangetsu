/*
//  CWFixedQueue.m
//  Zangetsu
//
//  Created by Colin Wheeler on 9/10/12.
//
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

#import "CWFixedQueue.h"

@interface CWFixedQueue()
@property(retain) NSMutableArray *storage;
@end

@implementation CWFixedQueue

-(id)initWithCapacity:(NSUInteger)capacity {
	self = [super init];
	if (!self) return nil;
	
	_storage = [NSMutableArray array];
	_capacity = capacity;
	_evictionBlock = nil;
	
	return self;
}

- (id)init
{
    self = [super init];
    if (!self) return nil;
	
	_storage = [NSMutableArray array];
	_capacity = 50;
	_evictionBlock = nil;
	
    return self;
}

-(NSUInteger)count {
	return self.storage.count;
}

-(id)objectAtIndexedSubscript:(NSUInteger)index {
	return [self.storage objectAtIndexedSubscript:index];
}

-(void)setObject:(id)object atIndexedSubscript:(NSUInteger)idx {
	[self.storage setObject:object
		 atIndexedSubscript:idx];
}

-(void)enqueue:(id)object {
	if (object) {
		if (![self.storage containsObject:object]) {
			[self.storage addObject:object];
			[self clearExcessObjects];
		} else {
			NSUInteger objectIndex = [self.storage indexOfObject:object];
			[self.storage removeObjectAtIndex:objectIndex];
			[self.storage addObject:object];
		}
	}
}

-(void)enqueueObjectsInArray:(NSArray *)array {
	if (array && (array.count > 0)) {
		[self.storage addObjectsFromArray:array];
		[self clearExcessObjects];
	}
}

-(void)clearExcessObjects {
	while (self.storage.count > self.capacity) {
		if (self.evictionBlock) self.evictionBlock(self.storage[0]);
		[self.storage removeObjectAtIndex:0];
	}
}

-(id)dequeue {
	if (self.storage.count > 0) {
		id dequeuedObject = self.storage[0];
		[self.storage removeObjectAtIndex:0];
		return dequeuedObject;
	}
	return nil;
}

-(void)enumerateContents:(void (^)(id object, NSUInteger index, BOOL *stop))block {
	[self.storage enumerateObjectsUsingBlock:block];
}

-(void)enumerateContentsWithOptions:(NSEnumerationOptions)options
						 usingBlock:(void (^)(id object, NSUInteger index, BOOL *stop))block {
	[self.storage enumerateObjectsWithOptions:options
								   usingBlock:block];
}

@end
