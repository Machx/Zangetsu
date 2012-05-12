/*
//  CWDoublyLinkedList.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/11/12.
//  Copyright (c) 2012. All rights reserved.
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

#import "CWDoublyLinkedList.h"

@interface CWDoublyLinkedListNode : NSObject
@property(retain) id data;
@property(retain) CWDoublyLinkedListNode *next;
@property(retain) CWDoublyLinkedListNode *prev;
@end

@implementation CWDoublyLinkedListNode

@synthesize data = _value;
@synthesize next = _next;
@synthesize prev = _prev;

- (id)init
{
    self = [super init];
    if (self) {
        _value = nil;
		_next = nil;
		_prev = nil;
    }
    return self;
}

@end

@interface CWDoublyLinkedList ()
@property(readwrite, assign) NSUInteger count;
@property(nonatomic, retain) CWDoublyLinkedListNode *head;
@property(nonatomic, weak) CWDoublyLinkedListNode *tail;
@end

@implementation CWDoublyLinkedList

@synthesize count = _count;
@synthesize head = _head;
@synthesize tail = _tail;

- (id)init
{
    self = [super init];
    if (self) {
        _count = 0;
    }
    return self;
}

-(void)addObject:(id)anObject
{
	if(!anObject) { return; }
	
	CWDoublyLinkedListNode *node = [[CWDoublyLinkedListNode alloc] init];
	node.data = anObject;
	
	if (!self.head) {
		self.head = node;
		self.tail = node;
	} else {
		node.prev = self.tail;
		self.tail.next = node;
		self.tail = node;
	}
	
	self.count++;
}

-(void)insertObject:(id)anObject atIndex:(NSUInteger)index
{
	CWDebugLog(@"Unimplemented Method");
}

-(void)removeObjectAtIndex:(NSUInteger)index
{
	CWDebugLog(@"Unimplemented Method");
}

-(void)removeObject:(id)object
{
	CWDebugLog(@"Unimplemented Method");
}

-(id)objectAtIndex:(NSUInteger)index
{
	if (index > (self.count - 1)) {
		CWDebugLog(@"ERROR: Index beyond list bounds");
		return nil;
	}
	
	NSUInteger currentIndex = 0;
	CWDoublyLinkedListNode *node = self.head;
	
	while (currentIndex != index) {
		node = node.next;
		currentIndex++;
	}
	
	return node.data;
}

-(void)enumerateObjectsWithBlock:(void(^)(id object, BOOL *stop))block
{
	CWDebugLog(@"Unimplemented Method");
}

@end
