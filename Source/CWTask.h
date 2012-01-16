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
-(id)initWithExecutable:(NSString *)exec 
		   andArguments:(NSArray *)execArgs 
			atDirectory:(NSString *)path;
//Synchronous Launch Method
-(NSString *)launchTask:(NSError **)error;
//Experimental Asynchronous Methods
-(void)launchTaskOnQueue:(NSOperationQueue *)queue 
		   withCompletionBlock:(void (^)(NSString *output, NSError *error))block;
-(void)launchTaskOnGCDQueue:(dispatch_queue_t)queue
		withCompletionBlock:(void (^)(NSString *output, NSError *error))block;
@end
