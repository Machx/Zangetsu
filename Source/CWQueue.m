/*
//  CWQueue.m
//  Zangetsu
//
//  Created by Colin Wheeler on 10/29/11.
//  Copyright (c) 2011. All rights reserved.
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
 
#import "CWQueue.h"

@interface CWQueue()
//private internal ivar
@property(nonatomic, retain) NSMutableArray *queue;
@end

@implementation CWQueue

@synthesize queue;

//MARK: -
//MARK: Initiailziation

/**
 Initializes a CWQueue object with no contents
 
 Initializes & returns an empty CWQueue object ready to
 accept objects to be added to it.
 
 @return a CWQueue object ready to accept objects to be added to it.
 */
-(id)init {
	self = [super init];
	if (self) {
		queue = [[NSMutableArray alloc] init];
	}
	return self;
}

/**
 Initializes a CWQueue object with the contents of array
 
 When a CWQueue dequeues all the objects initialized from a NSArray
 it will enumerate object them in the same order in which they were
 added in the array going over object at index 0,1,2...etc. 
 
 @param array a NSArray object with the contents you with to initialize a CWQueue object with
 @return an initialized CWQueue instance object
 */
-(id)initWithObjectsFromArray:(NSArray *)array {
	self = [super init];
	if (self) {
		if ([array count] > 0) {
			queue = [[NSMutableArray alloc] initWithArray:array];
		} else {
			queue = [[NSMutableArray alloc] init];
		}
	}
	return self;
}

//MARK: -
//MARK: Add & Remove Objects

/**
 Removes the first object in the queue and returns its reference
 
 Grabs a reference to the first object in CWQueues objects and then
 removes it from the receiving queue object and returns its reference
 to you. If the queue has no objects in its storage then this method
 returns nil.
 
 @return a reference to the first object in the queue after removing it or nil if there are no objects in the queue.
 */
-(id)dequeueTopObject {
	if ([[self queue] count] == 0) { return nil; }
	id topObject = [[self queue] cw_firstObject];
	[[self queue] removeObjectAtIndex:0];
	return topObject;
}

/**
 Adds a object to the receiving objects queue
 
 Adds object to the receiving CWQueues internal storage. If the object is
 nil then this method simply does nothing.
 
 @param object a Objective-C object you want to add to the receivng queues storage. Must be non-nil or an assertion will be thrown.
 */
-(void)addObject:(id)object {
	if (object) {
		[[self queue] addObject:object];
	}
}

/**
 Adds the objects from the objects array to the receiving queue
 
 This takes the objects in order they are in the objects array and 
 appends them onto the receiving queues storage. If the object array 
 is empty(0 objects) or nil then this method simply does nothing.
 
 @param a NSArray of objects to be appended onto the receiving queues storage
 */
-(void)addObjectsFromArray:(NSArray *)objects {
	if (objects && ([objects count] > 0)) {
		[[self queue] addObjectsFromArray:objects];
	}
}

/**
 Removes all objects from the receiving queues storage
 */
-(void)removeAllObjects {
	[[self queue] removeAllObjects];
}

//MARK: -
//MARK: Enumeration Methods

/**
 Enumerates over the objects in the receiving queues storage in order
 
 Enumerates over the receiving queues objects in order. Each time the block
 is called it gives you a reference to the object in the queue currently being 
 enumerated over.
 */
-(void)enumerateObjectsInQueue:(void(^)(id object))block {
	for (id object in [self queue]) {
		block(object);
	}
}

/**
 Dequeues the queue with a block until the queue is empty or stop is set to YES
 
 Dequeues the receiving queue, until the queue is empty or until the BOOL pointer
 in the block is set to YES. If the receiving queue is empty then this method 
 will immediately return, otherwise it will dequeue the first object in the queue
 and return to your code (via the block) and pass to you the object being dequeued
 and the BOOL pointer to stop further dequeueing if you desire.
 */
-(void)dequeueOueueWithBlock:(void(^)(id object, BOOL *stop))block {
	if([[self queue] count] == 0) { return; }
	
	__block BOOL shouldStop = NO;
	id dequeuedObject = nil;
	
	do {
		dequeuedObject = [self dequeueTopObject];
		if(dequeuedObject != nil){
			block(dequeuedObject,&shouldStop);
		}
	} while (shouldStop == NO && dequeuedObject != nil);
}

//MARK: -
//MARK: Debug Information

/**
 Returns an NSString with a description of the queues storage
 
 @return a NSString detailing the queues internal storage
 */
-(NSString *)description {
	return [[self queue] description];
}

/**
 Returns a NSUInteger with the Queues object count
 
 @return a NSUInteger with the receing Queues object count
 */
-(NSUInteger)count {
	return [[self queue] count];
}

//MARK: -
//MARK: Comparison

/**
 Returns a BOOL indicating if aQueue is equal to the receiving queue
 */
-(BOOL)isEqualToQueue:(CWQueue *)aQueue {
	return [[[self queue] description] isEqualToString:[aQueue description]];
}

@end
