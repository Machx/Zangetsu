/*
//  CWTask.h
//  Zangetsu
//
//  Created by Colin Wheeler on 8/30/10.
//  Copyright 2010. All rights reserved.
//
 
 Copyright (c) 2013, Colin Wheeler
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 - Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <Foundation/Foundation.h>

/*
 This class is being considered for removal from this project, so it can be put
 into its own repository.
 */

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
@property(readonly, copy) NSString *executable;
@property(readonly, copy) NSString *directoryPath;
@property(readonly, assign) NSInteger successCode;
@property(readonly, retain) NSArray *arguments;
//public read/write vars
@property(copy) dispatch_block_t completionBlock;

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
 and executes the block. The block must not be nil.
 
 @param queue a NSOperationQueue to launch the task on
 @param output the launched tasks output
 @param error a NSError object with a error if something went wrong
 */
-(void)launchTaskOnQueue:(NSOperationQueue *)queue
	 withCompletionBlock:(void (^)(NSString *output, NSError *error))block;

/**
 adds a operation to the passed in gcd dispatch_qeueue_t queue and calls
 -launchTask: then when it is done returns back to the main thread via 
 dispatch_get_main_queue() and executes the block. The block must not be nil.
 
 @param queue a dispatch_queue_t to launch the task on
 @param output the contents of the launched tasks output
 @param error a NSError object with a error if something went wrong
 */
-(void)launchTaskOnGCDQueue:(dispatch_queue_t)queue
		withCompletionBlock:(void (^)(NSString *output, NSError *error))block;
@end
