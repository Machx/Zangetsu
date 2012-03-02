/*
//  CWBlockQueue.h
//  Zangetsu
//
//  Created by Colin Wheeler on 2/27/12.
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

/**
 CWBlockQueue is a lightweight alternative to NSOperationQueue
 Its job is to manage a GCD Queue (dispatch_queue_t) & make it easy to
 do things you wanted to do with NSOperationQueue like set target queues,
 set operations with completion blocks, barrier blocks, etc. Unlike 
 NSOperation(Queue) CWBlockQueue has been designed from the beginning for
 asynchronous operations, you can do some synchronous operations, but
 the bulk of the class has been designed with asynchronous operations in mind.
 This means the queue is not concerned with the state of operations, which is 
 why CWBlockOperation has no -isExecuting -isFinished, etc.
 */

#import <Foundation/Foundation.h>

@interface CWBlockOperation : NSObject
+(CWBlockOperation *)operationWithBlock:(dispatch_block_t)block;
@property(copy) dispatch_block_t completionBlock;
@end

enum CWBlockQueueTargetType {
	kCWBlockQueueTargetPrivateQueue = 0, //private GCD Queue
	kCWBlockQueueTargetMainQueue = 1, // dispatch blocks onto the main queue
	kCWBlockQueueTargetGCDLowPriority = 2, // DISPATCH_QUEUE_PRIORITY_LOW queue
	kCWBlockQueueTargetGCDNormalPriority = 3, // DISPATCH_QUEUE_PRIORITY_NORMAL queue
	kCWBlockQueueTargetGCDHighPriority = 4 // DISPATCH_QUEUE_PRIORITY_HIGH queue
};

@interface CWBlockQueue : NSObject
+(CWBlockQueue *)mainQueue;
+(CWBlockQueue *)globalDefaultQueue;
-(id)initWithQueueType:(NSInteger)type concurrent:(BOOL)concurrent label:(NSString *)label;
-(id)initWithGCDQueue:(dispatch_queue_t)gcdQueue;
@property(readonly,assign) dispatch_queue_t queue;
-(void)setTargetCWBlockQueue:(CWBlockQueue *)blockQueue;
-(void)setTargetGCDQueue:(dispatch_queue_t)GCDQueue;
-(void)addOperation:(CWBlockOperation *)operation;
-(void)addoperationWithBlock:(dispatch_block_t)block;
-(void)addSynchronousOperation:(CWBlockOperation *)operation;
-(void)addSynchronousOperationWithBlock:(dispatch_block_t)block;
-(void)executeWhenQueueIsFinished:(dispatch_block_t)block;
-(void)waitForQueueToFinish;
-(void)suspend;
-(void)resume;
@end
