//
//  CWPriorityQueue.h
//  ObjC_Playground
//
//  Created by Colin Wheeler on 12/18/12.
//  Copyright (c) 2012 Colin Wheeler. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 experimental priority queue implementation
 */

@interface CWPriorityQueue : NSObject

/**
 Adds the item to the queue and sorts all items by their priority
 
 The item is added to the Queue and then sorted by the priority it was given in
 this API. The lower an items number is the higher its priority is in the queue.
 
 @param item to be added to the queue
 @param priority this number is used to sort the item in the queue
 */
-(void)addItem:(id)item
  withPriority:(NSUInteger)priority;

/**
 Removes an item with the highest priority off the queue & returns it
 
 This method grabs a reference to the item with the highest priority on the
 queue (priority 0 or as close to it as there is), removes it from the queue
 and then returns it to you.
 
 @return the item with the highest priority (lowest #) or nil if queue is empty
 */
-(id)dequeue;

/**
 Returns all objects that have a priority in the queue that matches the argument
 
 @return an NSSet of all objects matching the given priority, or an empty set
 */
-(NSSet *)allObjectsOfPriority:(NSUInteger)priority;

-(NSUInteger)countofObjectsWithPriority:(NSUInteger)priority;

@end
