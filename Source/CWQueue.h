/*
//  CWQueue.h
//  Zangetsu
//
//  Created by Colin Wheeler on 10/29/11.
//  Copyright (c) 2012. All rights reserved.
//
 	*/
 
#import <Foundation/Foundation.h>

/**
 CWQueue is a Thread Safe Class	*/

@interface CWQueue : NSObject

/**
 Initializes a CWQueue object with the contents of array
 
 When a CWQueue dequeues all the objects initialized from a NSArray it will
 enumerate object them in the same order in which they were added in the array 
 going over object at index 0,1,2...etc.
 
<<<<<<< HEAD
 @param array a NSArray object with the contents you with to initialize a CWQueue object with
 @return an initialized CWQueue instance object	*/
=======
 @param array a NSArray to initialize the contents of the Queue with
 @return an initialized CWQueue instance object
 */
>>>>>>> upstream/master
-(id)initWithObjectsFromArray:(NSArray *)array;

/**
 Adds a object to the receiving objects queue
 
 Adds object to the receiving CWQueues internal storage. If the object is
 nil then this method simply does nothing.
 
<<<<<<< HEAD
 @param object a Objective-C object you want to add to the receivng queues storage. Must be non-nil or an assertion will be thrown.	*/
=======
 @param object added to the end of the queue. If nil an assertion is thrown.
 */
>>>>>>> upstream/master
-(void)enqueue:(id)object;

/**
 Adds the objects from the objects array to the receiving queue
 
 This takes the objects in order they are in the objects array and appends them
 onto the receiving queues storage. If the object array is empty(0 objects) or
 nil then this method simply does nothing.
 
 @param a NSArray of objects to be appended onto the receiving queues storage	*/
-(void)enqueueObjectsFromArray:(NSArray *)objects;

/**
 Removes all objects from the receiving queues storage	*/
-(void)removeAllObjects;

/**
 Removes the first object in the queue and returns its reference
 
 Grabs a reference to the first object in CWQueues objects and then removes it
 from the receiving queue object and returns it to you. If the queue has no 
 objects in its storage then this method returns nil.
 
<<<<<<< HEAD
 @return a reference to the first object in the queue after removing it or nil if there are no objects in the queue.	*/
=======
 @return a reference to the first object in the queue after removing it or nil
 */
>>>>>>> upstream/master
-(id)dequeue;

/**
 Dequeues the queue with a block until the queue is empty or stop is set to YES
 
<<<<<<< HEAD
 Dequeues the receiving queue, until the queue is empty or until the BOOL pointer
 in the block is set to YES. If the receiving queue is empty then this method 
 will immediately return, otherwise it will dequeue the first object in the queue
 and return to your code (via the block) and pass to you the object being dequeued
 and the BOOL pointer to stop further dequeueing if you desire.	*/
=======
 Dequeues the receiving queue, until the queue is empty or until the BOOL 
 pointer in the block is set to YES. If the receiving queue is empty then this
 method will immediately return, otherwise it will dequeue the first object in
 the queue and return to your code (via the block) and pass to you the object 
 being dequeued and the BOOL pointer to stop further dequeueing if you desire.
 */
>>>>>>> upstream/master
-(void)dequeueOueueWithBlock:(void(^)(id object, BOOL *stop))block;

/**
 Dequeues the queue objects while calling block, until it reaches targetObject
 
 This method dequeues the target queue until it reaches the specified target 
 object. If the target object does not exist in the queue or the targetObject is
 nil or there are no objects in the target queue, then this method just 
 immediately exists, never calling the block. Otherwise this method calls the 
 block till it has dequeued the target object and executed the last block.
 
<<<<<<< HEAD
 @param targetObject a Objective-C object in the queue you wish to dequeue all objects including it
 @param block a block with the object being dequeued as an argument	*/
=======
 @param targetObject the object you wish to dequeue to
 @param block a block with the object being dequeued as an argument
 */
>>>>>>> upstream/master
-(void)dequeueToObject:(id)targetObject withBlock:(void(^)(id object))block;

/**
 Enumerates over the objects in the receiving queues storage in order
 
<<<<<<< HEAD
 Enumerates over the receiving queues objects in order. Each time the block
 is called it gives you a reference to the object in the queue currently being 
 enumerated over.	*/
=======
 Enumerates over the receiving queues objects in order. Each time the block is 
 called it gives you a reference to the object in the queue currently being
 enumerated over.
 */
>>>>>>> upstream/master
-(void)enumerateObjectsInQueue:(void(^)(id object, BOOL *stop))block;

/**
 Allows you to view the head object without dequeueing it
 
 @return the object at the head of the queue	*/
-(id)peek;

/**
 Returns a BOOL value if the object passed in exists in the queue
 
 If the passed in object is non nil then this method queries the internal
 storage and returns a bool if the object is contained in the queue instance.
 
<<<<<<< HEAD
 @param object a non nil object you wish to query if it exists in the queue instance
 @return a BOOL with YES if the object is in the queue or NO if it isn't	*/
=======
 @param object an object you wish to query if it exists in the queue instance
 @return a BOOL with YES if the object is in the queue or NO if it isn't
 */
>>>>>>> upstream/master
-(BOOL)containsObject:(id)object;

/**
 Returns a BOOL value with the result of using the block on the queue data
 
 This method calls the block passing in an object in the receiving queue. When
 any block returns a YES result instead of NO then this method stops enumerating
 over the qeueue and returns the result. Otherwise all the queue is enumerated 
 over and the final result is returned. This method allows better inspection of
 all objects in the queue.
 
<<<<<<< HEAD
 @param a block taking a id obj argument which will the an object in the queue, and returning a BOOL value of YES or NO
 @return a BOOL value with YES if the block at any time 	*/
=======
 @param block passes an id obj argument and returns a BOOL if obj matches
 @return a BOOL value with YES if the block at any time 
 */
>>>>>>> upstream/master
-(BOOL)containsObjectWithBlock:(BOOL (^)(id obj))block;

/**
 Returns a NSUInteger with the Queues object count
 
 @return a NSUInteger with the receing Queues object count	*/
-(NSUInteger)count;

/**
 Returns a BOOL indicating if the queue is empty
 
 @return Returns YES if the queue object count is 0, otherwise it returns NO.	*/
-(BOOL)isEmpty;

/**
<<<<<<< HEAD
 Returns a BOOL indicating if aQueue is equal to the receiving queue	*/
=======
 Returns a BOOL indicating if aQueue is equal to the receiving queue
 
 @return a BOOL if the queues are equal
 */
>>>>>>> upstream/master
-(BOOL)isEqualToQueue:(CWQueue *)aQueue;

@end
