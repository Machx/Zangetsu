//
//  CWQueue.m
//  Zangetsu
//
//  Created by Colin Wheeler on 10/29/11.
//  Copyright (c) 2011. All rights reserved.
//

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
 
 Adds object to the receiving CWQueues internal storage.
 
 @param object a Objective-C object you want to add to the receivng queues storage. Must be non-nil or an assertion will be thrown.
 */
-(void)addObject:(id)object {
	NSParameterAssert(object);
	[[self queue] addObject:object];
}

-(void)addObjectsFromArray:(NSArray *)objects {
	NSParameterAssert(objects);
	if ([objects count] > 0) {
		[[self queue] addObjectsFromArray:objects];
	}
}

/**
 Removes all objects from the receiving queues storage
 */
-(void)removeAllObjects {
	[[self queue] removeAllObjects];
}

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
