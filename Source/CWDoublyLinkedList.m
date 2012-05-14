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

@synthesize data = _data;
@synthesize next = _next;
@synthesize prev = _prev;

- (id)init
{
    self = [super init];
    if (self) {
        _data = nil;
		_next = nil;
		_prev = nil;
    }
    return self;
}

-(NSString *)description
{
	NSString *debugDescription = [NSString stringWithFormat:@"( Node Value: %@\n Prev Node: %@\n Next Node: %@ )",_data,_prev,_next];
	return debugDescription;
}

@end

@interface CWDoublyLinkedList ()
@property(readwrite, assign) NSUInteger count;
@property(nonatomic, retain) CWDoublyLinkedListNode *head;
@property(nonatomic, weak) CWDoublyLinkedListNode *tail;
-(void)_removeObjectWithNode:(CWDoublyLinkedListNode *)node;
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
	if (!anObject) {
		CWDebugLog(@"Trying to insert a nill object. Exiting...");
		return;
	}
	if (index > (self.count)) {
		CWDebugLog(@"Index beyond list bounds");
		return;
	}
	if (!self.head && (index != 0)) {
		CWDebugLog(@"Trying to insert an object in a list with no objects and index > 0");
		return;
	}
	
	//if we can just append to the end
	//of the array then just do it to 
	//save time
	if (index == (self.count)) {
		[self addObject:anObject];
		return;
	}
	
	NSUInteger currentIndex = 0;
	CWDoublyLinkedListNode *node = self.head;
	
	while (currentIndex != index) {
		node = node.next;
		currentIndex++;
	}
	
	CWDoublyLinkedListNode *insertNode = [[CWDoublyLinkedListNode alloc] init];
	insertNode.data = anObject;
	
	CWDoublyLinkedListNode *nextNode = node;
	CWDoublyLinkedListNode *prevNode = node.prev;
	//take care of the insert node
	insertNode.next = nextNode;
	insertNode.prev = prevNode;
	//then the next node
	nextNode.prev = insertNode;
	//then the prev node
	prevNode.next = insertNode;
	
	self.count++;
}

-(void)_removeObjectWithNode:(CWDoublyLinkedListNode *)node
{
	CWDoublyLinkedListNode *prev = node.prev;
	CWDoublyLinkedListNode *next = node.next;
	prev.next = next;
	next.prev = prev;
}

-(void)removeObjectAtIndex:(NSUInteger)index
{
	if (index > (self.count - 1)) {
		CWDebugLog(@"Index beyond list bounds");
		return;
	}
	if (!self.head) {
		CWDebugLog(@"Trying to delete an object in a list with no objects and index > 0");
		return;
	}
	
	CWDoublyLinkedListNode *node = self.head;
	NSUInteger currentIndex = 0;
	
	while (currentIndex != index) {
		node = node.next;
		currentIndex++;
	}
	
	[self _removeObjectWithNode:node];
}

-(void)removeObject:(id)object
{
	if (!self.head) {
		CWDebugLog(@"Oops you tried to remove an object from an empty linked list");
		return;
	}
	
	CWDoublyLinkedListNode *node = self.head;
	
	while (node) {
		if ([node.data isEqual:object]) {
			[self _removeObjectWithNode:node];
		}
		node = node.next;
	}
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
	if (!self.head) {
		CWDebugLog(@"Trying to enumerate object with an empty array");
		return;
	}
	
	CWDoublyLinkedListNode *node = self.head;
	BOOL shouldStop = NO;
	
	while (node) {
		block(node.data,&shouldStop);
		if (shouldStop == YES) {
			break;
		}
		node = node.next;
	}
}

@end
