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

@synthesize queue = _queue;

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
		_queue = [[NSMutableArray alloc] init];
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
			_queue = [[NSMutableArray alloc] initWithArray:array];
		} else {
			_queue = [[NSMutableArray alloc] init];
		}
	}
	return self;
}

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
	id topObject = [[self queue] objectAtIndex:0]; //change back to cw_firstObject sometime
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

//MARK: Query Methods

/**
 Returns a BOOL value if the object passed in exists in the queue
 
 If the passed in object is non nil then this method queries the internal
 storage and returns a bool if the object is contained in the queue instance.
 
 @param object a non nil object you wish to query if it exists in the queue instance
 @return a BOOL with YES if the object is in the queue or NO if it isn't
 */
-(BOOL)containsObject:(id)object {
	if (object && [[self queue] containsObject:object]) {
		return YES;
	}
	return NO;
}

/**
 Returns a BOOL value with the result of using the block on the queue data
 
 This method calls the block passing in an object in the receiving queue. When
 any block returns a YES result instead of NO then this method stops enumerating
 over the qeueue and returns the result. Otherwise all the queue is enumerated over
 and the final result is returned. This method allows better inspection of all 
 objects in the queue.
 
 @param a block taking a id obj argument which will the an object in the queue, and returning a BOOL value of YES or NO
 @return a BOOL value with YES if the block at any time 
 */
-(BOOL)containsObjectWithBlock:(BOOL (^)(id obj))block {
	for (id obj in [self queue]) {
		if (block(obj)) {
			return YES;
		}
	}
	return NO;
}

/**
 Returns the object in front of the targetObject
 
 If the target object is not in the queue this returns nil immediately.
 If the target object is at the front of the queue then this method
 returns nil. Otherwise it looks up the object in front of the target
 object and returns that object
 
 @param targetObject the object which you are wanting to know what is in front of it
 @return the object in front of the target object or nil if something went wrong.
 */
-(id)objectInFrontOf:(id)targetObject
{
	//make sure we actually contain target object
	if (![[self queue] containsObject:targetObject])
		return nil;
	//make sure the target object isn't already the frontmost object
	if ([targetObject isEqual:[[self queue] objectAtIndex:0]])
		return nil;
	
	NSUInteger index = ( [[self queue] indexOfObject:targetObject] - 1 );
	id frontObject = [[self queue] objectAtIndex:index];
	return frontObject;
}

/**
 Returns the object behind the target object or nil if something went wrong
 
 Returns the object behind the target object or nil if either the target object
 is at the end of the queue or something went wrong.
 
 @param targetObject the target object which you want to know the object behind it in the queue
 @return the object behind target object or nil
 */
-(id)objectBehind:(id)targetObject
{
	if (![[self queue] containsObject:targetObject])
		return nil;
	
	NSUInteger objectIndex = ( [[self queue] indexOfObject:targetObject] + 1 );
	if (objectIndex > ( [[self queue] count] - 1 ))
		return nil;
	
	return [[self queue] objectAtIndex:objectIndex];
}

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
		if(dequeuedObject){
			block(dequeuedObject,&shouldStop);
		}
	} while ((shouldStop == NO) && (dequeuedObject));
}

/**
 Dequeues the queue objects till it reaches targetObject, each time it dequeues an object it calls block
 
 This method dequeues the target queue until it reaches the specified target object. If
 the target object does not exist in the queue or the targetObject is nil or there are
 no objects in the target queue, then this method just immediately exists, never calling
 the block. Otherwise this method calls the block till it has dequeued the target object 
 and executed the last block.
 
 @param targetObject a Objective-C object in the queue you wish to dequeue all objects including it
 @param block a block with the object being dequeued as an argument
 */
-(void)dequeueToObject:(id)targetObject withBlock:(void(^)(id object))block 
{
	if ((![[self queue] containsObject:targetObject]) ||
		([[self queue] count] == 0)) {
		return;
	}
	
	id dequeuedObject = nil;
	
	do {
		dequeuedObject = [self dequeueTopObject];
		if (dequeuedObject) {
			block(dequeuedObject);
		}
	} while (dequeuedObject && (targetObject != dequeuedObject));
}

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

//MARK: Comparison

/**
 Returns a BOOL indicating if aQueue is equal to the receiving queue
 */
-(BOOL)isEqualToQueue:(CWQueue *)aQueue {
	return [[[self queue] description] isEqualToString:[aQueue description]];
}

@end
