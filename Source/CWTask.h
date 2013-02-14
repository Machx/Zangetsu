/*
//  CWTask.h
//  Zangetsu
//
//  Created by Colin Wheeler on 8/30/10.
//  Copyright 2010. All rights reserved.
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

#import <Foundation/Foundation.h>

typedef void (^TaskCompletionBlock)(void);

/* Errors */
/* Error Domain */
static NSString * const kCWTaskErrorDomain = @"com.Zangetsu.CWTask";
/* Invalid Executable Path */
static const NSInteger kCWTaskInvalidExecutableErrorCode =         1;
/* Invalid Directory specified to operate in */
static const NSInteger kCWTaskInvalidDirectoryErrorCode =          2;
/* Task can only be run 1 and it has already been launched */
static const NSInteger kCWTaskAlreadyRunErrorCode =                3;
/* Task encountered an exception when run */
static const NSInteger kCWTaskEncounteredExceptionOnRunErrorCode = 4;

/* Task Code */
/* Task hasn't been launched yet */
static const NSInteger kCWTaskNotLaunchedErrorCode =           -1729;

@interface CWTask : NSObject

//public readonly vars
@property(readonly, retain) NSString *executable;
@property(readonly, retain) NSString *directoryPath;
@property(readonly, assign) NSInteger successCode;
@property(readonly, retain) NSArray *arguments;
//public read/write vars
@property(copy) TaskCompletionBlock completionBlock;

//public api

/**
 designated initializer
 
 @param exec a string with the full path to the executable to be launched
 @param execArgs a NSArray of NSString arguments (optional)
 @param path a string with the full path to launch the task in (optional)
 @return a CWTask Object
 **/
-(id)initWithExecutable:(NSString *)exec 
		   andArguments:(NSArray *)execArgs 
			atDirectory:(NSString *)path;
//Synchronous Launch Method

/**
 Launches the task. Performs validation on the task to make sure all passed in 
 parameters are good, configures the internal task object and then runs it and 
 gets back the returned data from the task as a NSString object and then 
 performs post run operations if necessary.
 
 @param error a NSError object to be written to if something fails
 @return a NSString with the output of the launched task if successful else nil
 **/
-(NSString *)launchTask:(NSError **)error;

/**
 Launches the task on a private queue & returns the result in a completion block
 
 This is exactly similar to using -launchTaskonGCDQueue except CWTask is 
 creating the private queue to use.
 
 @param block the completion block called when the task is done, cannot be nil.
 */
-(void)launchTaskWithResult:(void (^)(NSString *output, NSError *error))block;

/**
 adds a operation to the passed in NSOperationQueue and calls -launchTask: then 
 when it is done returns back to the main thread via NSOperationQueue mainQueue 
 and executes the block.
 
 @param queue a NSOperationQueue to launch the task on
 @param output the launched tasks output
 @param error a NSError object with a error if something went wrong
 */
-(void)launchTaskOnQueue:(NSOperationQueue *)queue
		   withCompletionBlock:(void (^)(NSString *output, NSError *error))block;

/**
 adds a operation to the passed in gcd dispatch_qeueue_t queue and calls
 -launchTask: then when it is done returns back to the main thread via 
 dispatch_get_main_queue() and executes the block
 
 @param queue a dispatch_queue_t to launch the task on
 @param output the contents of the launched tasks output
 @param error a NSError object with a error if something went wrong
 */
-(void)launchTaskOnGCDQueue:(dispatch_queue_t)queue
		withCompletionBlock:(void (^)(NSString *output, NSError *error))block;
@end
