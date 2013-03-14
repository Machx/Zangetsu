/*
//  CWStack.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/24/11.
//  Copyright 2012. All rights reserved.
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

#import "CWStack.h"

@interface CWStack()
@property(retain) NSMutableArray *dataStore;
@property(assign) dispatch_queue_t queue;
@end

static int64_t queueCounter = 0;

@implementation CWStack

/**
 Initializes an empty stack
 
 @return a empty CWStack instance
 */
- (id)init {
    self = [super init];
    if (!self) return nil;
	
	_dataStore = [[NSMutableArray alloc] init];
	const char *label = [[NSString stringWithFormat:@"com.Zangetsu.CWStack_%lli",
						  OSAtomicIncrement64(&queueCounter)] UTF8String];
	_queue = dispatch_queue_create(label, DISPATCH_QUEUE_SERIAL);
	
    return self;
}

-(id)initWithObjectsFromArray:(NSArray *)objects {
	self = [super init];
	if (!self) return nil;
	
	_dataStore = [[NSMutableArray alloc] init];
	const char *label = [[NSString stringWithFormat:@"com.Zangetsu.CWStack_%lli",
						  OSAtomicIncrement64(&queueCounter)] UTF8String];
	_queue = dispatch_queue_create(label, DISPATCH_QUEUE_SERIAL);
	if (objects.count > 0) [_dataStore addObjectsFromArray:objects];
	
	return self;
}

-(void)push:(id)object {
	dispatch_async(self.queue, ^{
		if (object) [self.dataStore addObject:object];
	});
}

-(id)pop {
	__block id object = nil;
	dispatch_sync(self.queue, ^{
		if (self.dataStore.count > 0) {
			object = [self.dataStore lastObject];
			[self.dataStore removeLastObject];
		}
	});
	return object;
}

-(NSArray *)popToObject:(id)object {
	__block NSMutableArray *poppedObjects = nil;
	if (![self.dataStore containsObject:object]) return nil;
	
	id currentObject = nil;
	while (![self.topOfStackObject isEqual:object]) {
		currentObject = [self pop];
		[poppedObjects addObject:currentObject];
	}
	return poppedObjects;
}

-(void)popToObject:(id)object withBlock:(void (^)(id obj))block {
	if (![self.dataStore containsObject:object]) return;
	
	while (![self.topOfStackObject isEqual:object]) {
		id obj = [self pop];
		block(obj);
	}
}

-(NSArray *)popToBottomOfStack {
	if(self.dataStore.count == 0) return nil;
	return [self popToObject:[self.dataStore cw_firstObject]];
}

-(id)topOfStackObject {
	__block id object = nil;
	dispatch_sync(self.queue, ^{
		if(self.dataStore.count == 0) return;
		object = [self.dataStore lastObject];
	});
	return object;
}

-(id)bottomOfStackObject {
	__block id object = nil;
	dispatch_sync(self.queue, ^{
		if (self.dataStore.count == 0) return;
		object = [self.dataStore cw_firstObject];
	});
	return object;
}

-(void)clearStack {
	dispatch_async(self.queue, ^{
		[self.dataStore removeAllObjects];
	});
}

-(BOOL)isEqualToStack:(CWStack *)aStack {
	__block BOOL isEqual = NO;
	dispatch_sync(self.queue, ^{
		isEqual = [aStack.dataStore isEqual:self.dataStore];
	});
	return isEqual;
}

-(BOOL)containsObject:(id)object {
	__block BOOL contains = NO;
	dispatch_sync(self.queue, ^{
		contains = [self.dataStore containsObject:object];
	});
	return contains;
}

-(BOOL)containsObjectWithBlock:(BOOL (^)(id object))block {
	__block BOOL contains = NO;
	dispatch_sync(self.queue, ^{
		NSUInteger index = [self.dataStore indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
			return block(obj);
		}];
		if (index != NSNotFound) contains = YES;
	});
	return contains;
}

/**
 returns a NSString with the contents of the stack
 
 @return a NSString object with the description of the stack contents
 */
-(NSString *)description {
	__block NSString *stackDescription = nil;
	dispatch_sync(self.queue, ^{
		stackDescription = [self.dataStore description];
	});
	return stackDescription;
}

-(BOOL)isEmpty {
    __block BOOL empty;
	dispatch_sync(self.queue, ^{
		empty = (self.dataStore.count <= 0);
	});
	return empty;
}

-(NSInteger)count {
    __block NSInteger theCount = 0;
	dispatch_sync(self.queue, ^{
		theCount = self.dataStore.count;
	});
	return theCount;
}

-(void)dealloc {
	dispatch_release(_queue);
}

@end
