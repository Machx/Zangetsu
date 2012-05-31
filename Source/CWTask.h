/*
//  CWTask.h
//  Zangetsu
//
//  Created by Colin Wheeler on 8/30/10.
//  Copyright 2010. All rights reserved.
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

#import <Foundation/Foundation.h>

typedef void (^TaskCompletionBlock)(void);

/* Errors */
/* Error Domain */
static NSString * const kCWTaskErrorDomain = @"com.Zangetsu.CWTask";
/* Invalid Executable Path */
static const NSInteger kCWTaskInvalidExecutable =         1;
/* Invalid Directory specified to operate in */
static const NSInteger kCWTaskInvalidDirectory =          2;
/* Task can only be run 1 and it has already been launched */
static const NSInteger kCWTaskAlreadyRun =                3;
/* Task encountered an exception when run */
static const NSInteger kCWTaskEncounteredExceptionOnRun = 4;

/* Task Code */
/* Task hasn't been launched yet */
static const NSInteger kCWTaskNotLaunched =           -1729;

@interface CWTask : NSObject

//public readonly vars
@property(nonatomic, readonly, retain) NSString *executable;
@property(nonatomic, readonly, retain) NSString *directoryPath;
@property(nonatomic, readonly, assign) NSInteger successCode;
@property(nonatomic, readonly, retain) NSArray *arguments;
//public read/write vars
@property(nonatomic, copy) TaskCompletionBlock completionBlock;

//public api

/**
 * designated initializer
 *
 * @param exec a string containing the full path to the executable to be launched
 * @param execArgs a NSArray of NSString objects containing arguments for the executable (optional)
 * @param path a string containing the full path you want the executable the be launched at (optional)
 * @return a CWTask Object
 */
-(id)initWithExecutable:(NSString *)exec 
		   andArguments:(NSArray *)execArgs 
			atDirectory:(NSString *)path;
//Synchronous Launch Method

/**
 * Launches the task. Performs validation on the task to make sure
 * all passed in parameters are good, configures the internal task
 * object and then runs it and gets back the returned data from the
 * task as a NSString object and then performs post run operations
 * if necessary.
 *
 * @param error a NSError object to be written to if something fails
 * @return a NSString with the output of the launched task if successful, otherwise the error reference is written to
 */
-(NSString *)launchTask:(NSError **)error;

//Experimental Asynchronous Methods

/**
 Launches the task on a private queue and returns the result in a completion block
 
 This is exactly similar to using -launchTaskonGCDQueue except CWTask is creating the private queue to use
 
 @param block the completion block to be called when the task has results to show. this must not be nil.
 */
-(void)launchTaskWithResult:(void (^)(NSString *output, NSError *error))block;

/**
 * adds a operation to the passed in NSOperationQueue and calls
 * -launchTask: then when it is done returns back to the main
 * thread via NSOperationQueue mainQueue and executes the block
 *
 * @param queue a NSOperationQueue to launch the task on
 * @param output passed to you in the completion block with the contents of the launched tasks output
 * @param error a NSError object with a error if something went wrong
 */
-(void)launchTaskOnQueue:(NSOperationQueue *)queue 
		   withCompletionBlock:(void (^)(NSString *output, NSError *error))block;

/**
 * adds a operation to the passed in gcd dispatch_qeueue_t queue and calls
 * -launchTask: then when it is done returns back to the main
 * thread via dispatch_get_main_queue() and executes the block
 *
 * @param queue a Grand Central Dispatch Queue (dispatch_queue_t) to launch the task on
 * @param output passed to you in the completion block with the contents of the launched tasks output
 * @param error a NSError object with a error if something went wrong
 */
-(void)launchTaskOnGCDQueue:(dispatch_queue_t)queue
		withCompletionBlock:(void (^)(NSString *output, NSError *error))block;
@end
