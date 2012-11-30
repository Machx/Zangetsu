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
@property(retain) NSMutableArray *stack;
@property(assign) dispatch_queue_t queue;
@end

@implementation CWStack

/**
 Initializes an empty stack
 
 @return a empty CWStack instance
 */
- (id)init
{
    self = [super init];
    if (self) {
		_stack = [[NSMutableArray alloc] init];
		_queue = dispatch_queue_create(CWUUIDCStringPrependedWithString(@"com.Zangetsu.CWStack_"), DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

-(id)initWithObjectsFromArray:(NSArray *)objects
{
	self = [super init];
	if (self) {
		_stack = [[NSMutableArray alloc] init];
		_queue = dispatch_queue_create(CWUUIDCStringPrependedWithString(@"com.Zangetsu.CWStack_"), DISPATCH_QUEUE_SERIAL);
		if ([objects count] > 0) {
			[_stack addObjectsFromArray:objects];
		}
	}
	return self;
}

-(void)push:(id)object
{
	dispatch_async(self.queue, ^{
		if (object) {
			[self.stack addObject:object];
		}
	});
}

-(id)pop
{
	__block id object;
	dispatch_sync(self.queue, ^{
		if ([self.stack count] == 0) {
			object = nil;
		} else {
			object = [self.stack lastObject];
			[self.stack removeLastObject];
		}
	});
	return object;
}

-(NSArray *)popToObject:(id)object
{	
	__block NSMutableArray *poppedObjects = nil;
	if (![self.stack containsObject:object]) { return nil; }
	
	id currentObject = nil;
	while (![self.topOfStackObject isEqual:object]) {
		currentObject = [self pop];
		[poppedObjects addObject:currentObject];
	}
	
	return poppedObjects;
}

-(void)popToObject:(id)object withBlock:(void (^)(id obj))block
{	
	if (![self.stack containsObject:object]) { return; }
	
	while (![self.topOfStackObject isEqual:object]) {
		id obj = [self pop];
		block(obj);
	}
}

-(NSArray *)popToBottomOfStack
{
	__block NSArray *poppedObjects = nil;
	
	if(self.stack.count == 0) { return nil; }
	poppedObjects = [self popToObject:[[self stack] cw_firstObject]];
	
	return poppedObjects;
}

-(id)topOfStackObject
{
	__block id object = nil;
	dispatch_sync(self.queue, ^{
		if([self.stack count] == 0) { return; }
		object = [self.stack lastObject];
	});
	return object;
}

-(id)bottomOfStackObject
{
	__block id object = nil;
	dispatch_sync(self.queue, ^{
		if ([self.stack count] == 0) { return; }
		object = [self.stack cw_firstObject];
	});
	return object;
}

-(void)clearStack
{
	dispatch_async(self.queue, ^{
		[self.stack removeAllObjects];
	});
}

-(BOOL)isEqualToStack:(CWStack *)aStack
{
	__block BOOL isEqual = NO;
	dispatch_sync(self.queue, ^{
		isEqual = [aStack.stack isEqual:self.stack];
	});
	return isEqual;
}

-(BOOL)containsObject:(id)object
{
	__block BOOL contains = NO;
	dispatch_sync(self.queue, ^{
		contains = [self.stack containsObject:object];
	});
	return contains;
}

-(BOOL)containsObjectWithBlock:(BOOL (^)(id object))block
{	
	__block BOOL contains = NO;
	dispatch_sync(self.queue, ^{
		for (id obj in self.stack) {
			if (block(obj)) {
				contains = YES;
				break;
			}
		}
	});
	return contains;
}

/**
 returns a NSString with the contents of the stack
 
 @return a NSString object with the description of the stack contents
 */
-(NSString *)description
{
	__block NSString *stackDescription = nil;
	dispatch_sync(self.queue, ^{
		stackDescription = [self.stack description];
	});
	return stackDescription;
}

-(BOOL)isEmpty
{
    __block BOOL empty;
	dispatch_sync(self.queue, ^{
		empty = ([self.stack count] <= 0);
	});
	return empty;
}

-(NSInteger)count
{
    __block NSInteger theCount = 0;
	dispatch_sync(self.queue, ^{
		theCount = [self.stack count];
	});
	return theCount;
}

-(void)dealloc
{
	dispatch_release(_queue);
}

@end
