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
@property(retain) CWDoublyLinkedListNode *head;
@property(weak) CWDoublyLinkedListNode *tail;
-(void)_removeObjectWithNode:(CWDoublyLinkedListNode *)node;
-(CWDoublyLinkedListNode *)_nodeAtIndex:(NSUInteger)index error:(NSError **)error;
@end

@implementation CWDoublyLinkedList

- (id)init
{
    self = [super init];
    if (self) {
        _count = 0;
		_head = nil;
		_tail = nil;
    }
    return self;
}

-(void)addObject:(id)anObject
{
	if(!anObject) {
		CWDebugLog(@"Error: Trying to add a nil object to a linked list. Exiting & doing nothing...");
		return;
	}
	
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
	
	CWDoublyLinkedListNode *node = [self _nodeAtIndex:index];
	
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
	
	self.count--;
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
	
	CWDoublyLinkedListNode *node = [self _nodeAtIndex:index];
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

-(CWDoublyLinkedListNode *)_nodeAtIndex:(NSUInteger)index
								  error:(NSError **)error
{
	NSUInteger maxCount = (self.count - 1);
	if (index > maxCount) {
		if (*error) {
			*error = CWCreateError(@"com.Zangetsu.CWDoublyLinkedList", 442,
								   [NSString stringWithFormat:@"Index %lu is beyond List Bounds %lu",
									index,maxCount]);
		}
		return nil;
	}
	
	NSUInteger currentIndex = 0;
	CWDoublyLinkedListNode *node = self.head;
	
	while (currentIndex != index) {
		node = node.next;
		currentIndex++;
	}
	
	return node;
}

-(id)objectAtIndex:(NSUInteger)index
{
	CWDoublyLinkedListNode *node = [self _nodeAtIndex:index];
	return node.data;
}

-(void)swapObjectAtIndex:(NSUInteger)index1 withIndex:(NSUInteger)index2
{
	NSUInteger maxIndex = (self.count - 1);
	if((index1 > maxIndex) || (index2 > maxIndex)) {
		NSError *error = CWCreateError(@"com.Zangetsu.CWDoublyLinkedList", 142,
									   @"Index beyond list bounds");
		CWLogError(error);
	}
	
	//TODO: make the errors individual, spit out which index is out of bounds
	
	CWDoublyLinkedListNode *node1 = [self _nodeAtIndex:index1];
	CWDoublyLinkedListNode *node2 = [self _nodeAtIndex:index2];
	
	id temp = node1.data;
	node1.data = node2.data;
	node2.data = temp;
}

-(CWDoublyLinkedList *)linkedListWithRange:(NSRange)range
{
	if ((range.length + range.location) > ( self.count - 1)) {
		CWDebugLog(@"Error: Range beyond bounds... Exiting now...");
		return nil;
	}
	
	CWDoublyLinkedList *returnList = [[CWDoublyLinkedList alloc] init];
	
	NSUInteger start = range.location;
	NSUInteger currentIndex = 0;
	
	CWDoublyLinkedListNode *node = self.head;
	
	while (currentIndex != start) {
		node = node.next;
		currentIndex++;
	}
	
	NSUInteger length = range.length;
	
	while (node && (length != 0)) {
		[returnList addObject:node.data];
		length--;
		node = node.next;
	}
	
	return returnList;
}

-(void)enumerateObjectsWithBlock:(void(^)(id object,NSUInteger index, BOOL *stop))block
{
	if (!self.head) {
		CWDebugLog(@"Trying to enumerate object with an empty array");
		return;
	}
	
	CWDoublyLinkedListNode *node = self.head;
	BOOL shouldStop = NO;
	NSUInteger idx = 0;
	
	while (node) {
		block(node.data,idx,&shouldStop);
		if (shouldStop == YES) {
			break;
		}
		node = node.next;
		idx++;
	}
}

-(void)enumerateObjectsInReverseWithBlock:(void(^)(id object, NSUInteger index, BOOL *stop))block
{
	if (!self.head) {
		CWDebugLog(@"Tryiing to enumerate an empty array.");
		return;
	}
	
	CWDoublyLinkedListNode *tail = self.tail;
	BOOL shouldStop = NO;
	NSUInteger currentIndex = self.count - 1;
	
	while (tail != nil) {
		block(tail.data, currentIndex, &shouldStop);
		if (shouldStop == YES) { break; }
		tail = tail.prev;
		currentIndex--;
	}
}

-(void)enumerateObjectsWithOption:(NSUInteger)option usingBlock:(void (^)(id object, NSUInteger index, BOOL *stop))block
{
	if (option == kCWDoublyLinkedListEnumerateReverse) {
		[self enumerateObjectsInReverseWithBlock:block];
	} else if(option == kCWDoublyLinkedListEnumerateForward) {
		[self enumerateObjectsWithBlock:block];
	}
}

@end
