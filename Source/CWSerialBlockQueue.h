/*
//  CWSerialBlockQueue.h
//  Zangetsu
//
//  Created by Colin Wheeler on 2/23/12.
//  Copyright (c) 2012. All rights reserved.
//
 	*/
 
#import <Foundation/Foundation.h>

@interface CWSerialBlockOperation : NSObject
/**
 Returns a new CWSerialBlockOperation object that executes block when it is dequeued
 
 @param block a dispatch_block_t block that must not be NULL
 @return a new CWSerialBlockOperation object	*/
+(CWSerialBlockOperation *)blockOperationWithBlock:(dispatch_block_t)block;
@end

@interface CWSerialBlockQueue : NSObject

/**
 Returns a new CWSerialBlockQueue initialized with a unique label
 
 @return a new CWSerialBlockQueue object	*/
- (id)init;

/**
 Returns a new CWSerialBlockQueue with the given label or a uniquely generated one
 
 @return a new CWSerialBlockQueue queue that is immediately beginning to execute blockOperations	*/
-(id)initWithLabel:(NSString *)qlabel;

/**
 Returns a new CWSerialBlockQueue that immediately submits all operation objects in blockOperations for execution
 
 @param blockOperations a NSArray of CWSerialBlockOperatiom objects
 @return a new CWSerialBlockQueue queue that is immediately beginning to execute blockOperations	*/
-(id)initWithLabel:(NSString *)qlabel andBlockOperationObjects:(NSArray *)blockOperations;

/**
 Returns a label associated with the internal dispatch_queue_t queue
 
 @return a NSString with the internetal dispatch_queue_t queue label	*/
-(NSString *)label;

/**
 Submits block for execution on the queue
 
 @param block the block to be executed on the queue	*/
-(void)addOperationwithBlock:(dispatch_block_t)block;

/**
 Adds the block operation to the receiver for execution
 
 @param operation a CWSerialBlockOperation object if this is nil this method does nothing	*/
-(void)addBlockOperation:(CWSerialBlockOperation *)operation;

/**
 Adds the block operation objects to the queue. 
 
 This method enumerates the contents of the array and checks to make sure that
 the objects are members of the class CWSerialBlockOperation. If they are then
 it calls -addBlockOperation: passing in the object
 
 @param a NSArray of CWSerialBlockOperation objects	*/
-(void)addBlockOperationObjects:(NSArray *)operationObjects;

/**	Resumes executing blocks on the queue */
-(void)resume;

/**
 Stops processing all blocks on the queue
 
 This does not effect the currently executing block but stops the
 queue from dequeueing any more blocks until it is resumed.	*/
-(void)suspend;

/**
 Synchronously waits for all currently enqued blocks to finish dequeing	*/
-(void)waitUntilAllBlocksHaveProcessed;

/**
 Asynchronously waits for all currently enqued blocks to finish and then executes block
 
 @param block the block to be executed once all operation opjects are finished executing	*/
-(void)executeWhenAllBlocksHaveFinished:(dispatch_block_t)block;
@end
