/*
//  CWStack.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/24/11.
//  Copyright 2011. All rights reserved.
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

#import "CWStack.h"

@interface CWStack()
@property(nonatomic, retain) NSMutableArray *stack;
@end

@implementation CWStack

@synthesize stack = _stack;

/**
 Initializes an empty stack
 
 @return a empty CWStack instance
 */
- (id)init
{
    self = [super init];
    if (self) {
		_stack = [[NSMutableArray alloc] init];
    }
    return self;
}

-(id)initWithObjectsFromArray:(NSArray *)objects
{
	self = [super init];
	if (self) {
		_stack = [[NSMutableArray alloc] init];
		if (objects.count > 0) {
			[_stack addObjectsFromArray:objects];
		}
	}
	return self;
}

-(void)push:(id)object
{
	if(object) { [self.stack addObject:object]; }
}

-(id)pop
{
	if(self.stack.count == 0) { return nil; }
	id lastObject = [self.stack lastObject];
	[self.stack removeLastObject];
	return lastObject;
}

-(NSArray *)popToObject:(id)object
{
	if (![self.stack containsObject:object]) { return nil; }
	
	NSMutableArray *stackArray = [[NSMutableArray alloc] init];
	id currentObject = nil;
	while (![self.topOfStackObject isEqual:object]) {
		currentObject = [self pop];
		[stackArray addObject:currentObject];
	}
	
	return stackArray;
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
	if(self.stack.count == 0) { return nil; }
	NSArray *stackArray = [self popToObject:[[self stack] cw_firstObject]];
	return stackArray;
}

-(id)topOfStackObject
{
	if(self.stack.count == 0) { return nil; }
	id topObj = [self.stack lastObject];
	return topObj;
}

-(id)bottomOfStackObject
{
	if(self.stack.count == 0) { return nil; }
	id bottomObj = [self.stack cw_firstObject];
	return bottomObj;
}

-(void)clearStack
{
	[self.stack removeAllObjects];
}

-(BOOL)isEqualToStack:(CWStack *)aStack
{
	if ([[aStack description] isEqualToString:[self description]]) {
		return YES;
	}
	return NO;
}

-(BOOL)containsObject:(id)object
{
	return [self.stack containsObject:object];
}

-(BOOL)containsObjectWithBlock:(BOOL (^)(id object))block
{	
	for (id obj in self.stack) {
		if (block(obj)) {
			return YES;
		}
	}
	return NO;
}

/**
 returns a NSString with the contents of the stack
 
 @return a NSString object with the description of the stack contents
 */
-(NSString *)description
{
	return [self.stack description];
}

-(BOOL)isEmpty
{
    return ([self.stack count] <= 0);
}

-(NSInteger)count
{
    return [self.stack count];
}

@end
