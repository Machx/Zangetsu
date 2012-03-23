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
//Private internal ivar
@property(nonatomic, retain) NSMutableArray *stack;
@end

@implementation CWStack

@synthesize stack = _stack;

- (id)init
{
    self = [super init];
    if (self) {
		_stack = [[NSMutableArray alloc] init];
    }
    return self;
}

/**
 initializes a CWStack object with the content of the array passed in
 
 If the NSArray passed in has at least 1 object
 
 @param objects a NSArray whose contents you want a CWStack object initialized with
 @return an intialized CWStack object
 */
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

/**
 Pushes an object onto the stack
 
 Pushes the object onto the stack instance. If the object
 is nil then this method does nothing.
 
 @param object the object you want pushed onto the stack
 */
-(void)push:(id)object
{
	if(!object) { return; }
	[self.stack addObject:object];
}

/**
 pops an object off of the top of the CWStack object and returns that popped object
 
 @return the object at the top of the stack
 */
-(id)pop
{
	if(self.stack.count == 0) { return nil; }
	id lastObject = [self.stack lastObject];
	[self.stack removeLastObject];
	return lastObject;
}

/**
 continuously pops objects off the stack until the object specified is found
 
 popToObject pops all objects off the stack until it finds the object specified in the 
 passed in value. If the object is not in the stack it returns nil immediately, otherwise 
 a NSArray containing all objects popped off the stack before the object specified is returned
 
 @param object the object you wish the stack to be popped off to
 @return nil if the object is not in the array otherwise a NSArray of all popped off objects
 */
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

/**
 pops to the object in the stack, for each object encountered the block is called passing in the object encountered
 
 If the object provided does not exist in the stack then the method returns immediately 
 
 @param object The object you wish to pop the stack to
 @param block the block that will be executed upon encountering each object in the stack until the object specified is found
 */
-(void)popToObject:(id)object withBlock:(void (^)(id obj))block
{
	if (![self.stack containsObject:object]) { return; }
	
	while (![self.topOfStackObject isEqual:object]) {
		id obj = [self pop];
		block(obj);
	}
}

/**
 pops all objects off the stack except for the bottom object
 
 @return a NSArray of all popped off objects
 */
-(NSArray *)popToBottomOfStack
{
	if(self.stack.count == 0) { return nil; }
	NSArray *stackArray = [self popToObject:[[self stack] cw_firstObject]];
	return stackArray;
}

/**
 returns the object at the top of the stack
 
 @return the objct at the top of the stack
 */
-(id)topOfStackObject
{
	if(self.stack.count == 0) { return nil; }
	id topObj = [self.stack lastObject];
	return topObj;
}

/**
 returns the object at the bottom of the stack
 
 @return the objct at the bottom of the stack
 */
-(id)bottomOfStackObject
{
	if(self.stack.count == 0) { return nil; }
	id bottomObj = [self.stack cw_firstObject];
	return bottomObj;
}

/**
 clears the stack of all objects
 */
-(void)clearStack
{
	[self.stack removeAllObjects];
}

/**
 checks to see if the stack contents of another CWStack object are the same compared to the receiver
 
 first checks to see if the other object is a CWStack Object and then checks to see if their contents
 are the same. This method does this by comparing the string description of the contents to the receivers
 string description of its contents. This way is used currently because the private ivar that holds the 
 contents is hidden and never exposed in the public header for CWStack. This is as close to direct ivar
 access to private contents that you will get in CWStack.
 
 @param object another CWStack object which you wish to compare its contents to against the receiver object
 @return a BOOL with YES if the 2 stack objects have the same contents or NO if they don't
 */
-(BOOL)isEqualToStack:(CWStack *)aStack
{
	if ([[aStack description] isEqualToString:[self description]]) {
		return YES;
	}
	return NO;
}

/**
 Returns a bool indicating if the pass in object is contained in the CWStack storage
 
 @param object any NSObject subclass instance you wish to see if its contained in the stack
 @return a BOOL with a value of YES if the object is contained in the stack, otherwise NO
 */
-(BOOL)containsObject:(id)object
{
	return [self.stack containsObject:object];
}

/**
 returns a NSString with the contents of the stack
 
 @return a NSString object with the description of the stack contents
 */
-(NSString *)description
{
	return [self.stack description];
}

/**
 returns if the stack is currently empty
 
 @return a BOOL indicating if the stack is empty
 */
-(BOOL)isEmpty
{
    return ([self.stack count] <= 0);
}

/**
 returns a count of objects in the current stack object
 
 @return a NSInteger indicating how many objects are currently in the stack
 */
-(NSInteger)count
{
    return [self.stack count];
}

@end
