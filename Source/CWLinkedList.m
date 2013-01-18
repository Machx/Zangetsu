/*
 //  CWLinkedList.m
 //  Zangetsu
 //
 //  Created by Colin Wheeler on 5/11/12.
 //  Copyright (c) 2013. All rights reserved.
 //
 
 Copyright (c) 2013 Colin Wheeler
 
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

#import "CWLinkedList.h"

@interface CWLinkedListNode : NSObject
@property(retain) id data;
@property(retain) CWLinkedListNode *next;
@property(retain) CWLinkedListNode *prev;
@end

@implementation CWLinkedListNode

- (id)init {
    self = [super init];
    if (self) {
        _data = nil;
		_next = nil;
		_prev = nil;
    }
    return self;
}

-(NSString *)description {
	return [NSString stringWithFormat:@"( Node Value: %@\n Prev Node: %@\n Next Node: %@ )",
			_data,_prev,_next];
}

@end

@interface CWLinkedList ()
@property(readwrite, assign) NSUInteger count;
@property(retain) CWLinkedListNode *head;
@property(weak) CWLinkedListNode *tail;
-(void)_removeObjectWithNode:(CWLinkedListNode *)node;
-(CWLinkedListNode *)_nodeAtIndex:(NSUInteger)index error:(NSError **)error;
-(BOOL)hasInsertObjectErrorsWithObject:(id)object andIndex:(NSUInteger)index;
@end

@implementation CWLinkedList

- (id)init {
    self = [super init];
    if (self) {
        _count = 0;
		_head = nil;
		_tail = nil;
    }
    return self;
}

-(void)addObject:(id)anObject {
	if(!anObject) { return; }
	
	CWLinkedListNode *node = [[CWLinkedListNode alloc] init];
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

-(BOOL)hasInsertObjectErrorsWithObject:(id)object
							  andIndex:(NSUInteger)index {
	if (object == nil) {
		//TODO: publicly document (and if needed change) these error #'s
		CWLogErrorInfo(kCWDoublyLinkedListErrorDomain,
					   442,
					   @"Attemtping to insert a nil object");
		return YES;
	}
	if ((!self.head) && (index != 0)) {
		CWLogErrorInfo(kCWDoublyLinkedListErrorDomain,
					   443,
					   @"Trying to insert an object in a list with no objects and index > 0");
		return YES;
	}
	
	return NO;
}

-(void)insertObject:(id)anObject atIndex:(NSUInteger)index {
	//will log any errors it encounters...
	if ([self hasInsertObjectErrorsWithObject:anObject
									 andIndex:index]) {
		return;
	}
	
	/**
	 if we are appending onto the exact end of the array
	 then calling -addObject: will save us a lot of time
	 */
	if (index == self.count) {
		[self addObject:anObject];
		return;
	}
	
	NSError *error;
	CWLinkedListNode *node = [self _nodeAtIndex:index error:nil];
	if(node == nil) {
		CWLogError(error);
		return;
	}
	
	CWLinkedListNode *insertNode = [[CWLinkedListNode alloc] init];
	insertNode.data = anObject;
	
	CWLinkedListNode *nextNode = node;
	CWLinkedListNode *prevNode = node.prev;

	insertNode.next = nextNode;
	insertNode.prev = prevNode;
	nextNode.prev = insertNode;
	prevNode.next = insertNode;
	self.count++;
}

-(void)_removeObjectWithNode:(CWLinkedListNode *)node {
	CWLinkedListNode *prev = node.prev;
	CWLinkedListNode *next = node.next;
	prev.next = next;
	next.prev = prev;
	self.count--;
}

-(void)removeObjectAtIndex:(NSUInteger)index {
	if (!self.head) {
		CWLogErrorInfo(kCWDoublyLinkedListErrorDomain,
					   450,
					   @"Trying to delete an object in a list with no objects and index > 0");
		return;
	}
	
	CWLinkedListNode *node = [self _nodeAtIndex:index error:nil];
	[self _removeObjectWithNode:node];
}

-(void)removeObject:(id)object {
	if (!self.head) { return; }
	
	CWLinkedListNode *node = self.head;
	while (node) {
		if ([node.data isEqual:object]) {
			[self _removeObjectWithNode:node];
			return;
		}
		node = node.next;
	}
}

-(CWLinkedListNode *)_nodeAtIndex:(NSUInteger)index
							error:(NSError **)error {
	NSUInteger maxCount = (self.count - 1);
	if (CWErrorSet(index > maxCount, ^NSError *{
		return CWCreateError(kCWDoublyLinkedListErrorDomain, 442,
							 [NSString stringWithFormat:@"Index %lu is beyond List Bounds %lu",
							  index,maxCount]);
	}, error)) {
		return nil;
	}
	if (CWErrorSet(self.head == nil, ^NSError *{
		return CWCreateError(kCWDoublyLinkedListErrorDomain, 445,
							 @"Attempting to get Node at index in a list with no elements");
	}, error)) {
		return nil;
	}
	
	NSUInteger currentIndex = 0;
	CWLinkedListNode *node = self.head;
	while (currentIndex != index) {
		node = node.next;
		currentIndex++;
	}
	return node;
}

-(id)objectAtIndexedSubscript:(NSUInteger)index {
	NSError *error;
	CWLinkedListNode *node = [self _nodeAtIndex:index
										  error:&error];
	if (!node) {
		CWLogError(error);
		return nil;
	}
	return node.data;
}

-(void)setObject:(id)object atIndexedSubscript:(NSUInteger)idx {
	CWLinkedListNode *node = [self _nodeAtIndex:idx
										  error:nil];
	node.data = object;
}

-(void)swapObjectAtIndex:(NSUInteger)index1
			   withIndex:(NSUInteger)index2 {
	NSError *node1Error, *node2Error;
	CWLinkedListNode *node1 = [self _nodeAtIndex:index1
										   error:&node1Error];
	CWLinkedListNode *node2 = [self _nodeAtIndex:index2
										   error:&node2Error];
	if(!node1) { CWLogError(node1Error); return; }
	if(!node2) { CWLogError(node2Error); return; }
	
	id temp = node1.data;
	node1.data = node2.data;
	node2.data = temp;
}

-(CWLinkedList *)linkedListWithRange:(NSRange)range {
	if ((range.length + range.location) > ( self.count - 1)) {
		CWLogErrorInfo(kCWDoublyLinkedListErrorDomain,
					   442,
					   @"Error: Range beyond bounds... Exiting now...");
		return nil;
	}
	
	CWLinkedList *returnList = [[CWLinkedList alloc] init];
	
	NSUInteger start = range.location;
	NSUInteger currentIndex = 0;
	
	CWLinkedListNode *node = self.head;
	
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

-(void)enumerateObjectsWithBlock:(void(^)(id object,NSUInteger index, BOOL *stop))block {
	if (!self.head) { return; }
	
	CWLinkedListNode *node = self.head;
	BOOL shouldStop = NO;
	NSUInteger currentIndex = 0;
	while (node) {
		block(node.data,currentIndex,&shouldStop);
		if (shouldStop == YES) {
			break;
		}
		node = node.next;
		currentIndex++;
	}
}

-(void)enumerateObjectsInReverseWithBlock:(void(^)(id object, NSUInteger index, BOOL *stop))block {
	if (!self.head) { return; }
	
	CWLinkedListNode *tail = self.tail;
	BOOL shouldStop = NO;
	NSUInteger currentIndex = self.count - 1;
	
	while (tail != nil) {
		block(tail.data, currentIndex, &shouldStop);
		if (shouldStop == YES) { break; }
		tail = tail.prev;
		currentIndex--;
	}
}

-(void)enumerateObjectsWithOption:(CWDoublyLinkedListEnumerationOption)option
					   usingBlock:(void (^)(id object, NSUInteger index, BOOL *stop))block {
	if (option == kCWDoublyLinkedListEnumerateReverse) {
		[self enumerateObjectsInReverseWithBlock:block];
	} else if(option == kCWDoublyLinkedListEnumerateForward) {
		[self enumerateObjectsWithBlock:block];
	}
}

@end
