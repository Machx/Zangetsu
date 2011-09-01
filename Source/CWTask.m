/*
//  CWTask.m
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

#import "CWTask.h"

@interface CWTask ()
// Publicly declared
@property (nonatomic, readwrite, retain) NSString * executable;
@property (nonatomic, readwrite, retain) NSArray * arguments;
@property (nonatomic, readwrite, retain) NSString * directoryPath;
@property (nonatomic, readwrite, assign) NSInteger successCode;
// Privately Declared
@property (nonatomic, readwrite, assign) BOOL taskHasRun;
@property (nonatomic, readwrite, assign) BOOL inAsynchronous;
@property (nonatomic, readwrite, retain) NSPipe * pipe;
@property (nonatomic, readwrite, retain) NSTask * cwTask;
// Private Methods
- (void) _configureTask;
- (BOOL) _validateTask:(NSError **)error;
- (void) _performPostRunActionsIfApplicable;
- (NSString *) _resultsStringFromLaunchedTask;
- (BOOL) _validateExecutable:(NSError **)error;
- (BOOL) _validateDirectoryPathIfApplicable:(NSError **)error;
- (BOOL) _validateTaskHasRun:(NSError **)error;
@end

@implementation CWTask

@synthesize executable;
@synthesize arguments;
@synthesize directoryPath;
@synthesize successCode;
@synthesize completionBlock;
@synthesize taskHasRun;
@synthesize inAsynchronous;
@synthesize cwTask;
@synthesize pipe;

#pragma mark -
#pragma mark Public API

/**
 * designated initializer
 *
 * @param exec a string containing the full path to the executable to be launched
 * @param execArgs a NSArray of NSString objects containing arguments for the executable (optional)
 * @param path a string containing the full path you want the executable the be launched at (optional)
 * @return a CWTask Object
 */
- (id) initWithExecutable:(NSString *)exec
   andArguments:(NSArray *)execArgs
   atDirectory:(NSString *)path {
    self = [super init];
    if (self) {
        executable = exec;
        arguments = execArgs;
        directoryPath = path;
        successCode = kCWTaskNotLaunched;
        taskHasRun = NO;
        inAsynchronous = NO;
        cwTask = [[NSTask alloc] init];
    }
    return self;
}

/**
 * default implementation so if someone calls this and then
 * tries to launch the task the method will immediately see
 * that executable == nil and therefore will return immediatly
 * with an error about the executable.
 *
 * @return an invalid CWTask object
 */
- (id) init {
    self = [super init];
    if (self) {
        executable = nil;
        arguments = nil;
        directoryPath = nil;
        successCode = kCWTaskNotLaunched;
        taskHasRun = NO;
        inAsynchronous = NO;
        cwTask = nil;
    }
    return self;
}

/**
 * Description for debug information
 */
- (NSString *) description {
    NSString * desc = [NSString stringWithFormat:@"CWTask::Executable('%@')\nArguements: %@\nDirectory Path:%@",
                       executable, arguments, directoryPath];

    return desc;
}

/**
 * Any arguments to the task are set here
 */
- (void) _configureTask {
    [self.cwTask setLaunchPath:self.executable];
    self.pipe = [NSPipe pipe];
    [self.cwTask setStandardOutput:self.pipe];
    if (arguments.count > 0) {
        [cwTask setArguments:self.arguments];
    }
    if (self.directoryPath) {
        [cwTask setCurrentDirectoryPath:self.directoryPath];
    }
}

/**
 * Runs all the validation methods and returns NO if any of them fail,
 * returns YES otherwise
 *
 * @param error a NSError object to be written to if something fails
 * @return (BOOL) NO if the task fails any validation test, YES otherwise
 */
- (BOOL) _validateTask:(NSError **)error {
    if (![self _validateExecutable:error] ||
        ![self _validateDirectoryPathIfApplicable:error] ||
        ![self _validateTaskHasRun:error]) {
        return NO;
    }
    return YES;
}

/**
 * Checks for a non nil value of executable and checks that the executable actually exists
 * if either fail it writes out a kCWTaskInvalidExecutable error to the NSError pointer and
 * returns NO
 *
 * @param error a NSError object to be written to if something fails
 * @return (BOOL) NO is the executable specified doesn't exist otherwise returns YES
 */
- (BOOL) _validateExecutable:(NSError **)error {
    if (self.executable == nil || ![[NSFileManager defaultManager] fileExistsAtPath:self.executable]) {
        if (*error) {
            *error = CWCreateError(kCWTaskInvalidExecutable, kCWTaskErrorDomain, @"Executable Path provided doesn't exist");
        }
        return NO;
    }
    return YES;
}

/**
 * if there is a non nil directory path provided it validates that it actually exists
 * if that fails it writes out a kCWTaskInvalidDirectory error and returns NO
 *
 * @param error a NSError object to be written to if something fails
 * @return (BOOL) YES if the directory path exists otherwise returns NO
 */
- (BOOL) _validateDirectoryPathIfApplicable:(NSError **)error {
    if (self.directoryPath) {
        if (![[NSFileManager defaultManager] fileExistsAtPath:self.directoryPath]) {
            if (*error) {
                *error = CWCreateError(kCWTaskInvalidDirectory, kCWTaskErrorDomain, @"The Directory Specified does not exist & is invalid");
            }
            return NO;
        }
    }
    return YES;
}

/**
 * CWTask behaves just like  NSTask in that each task object may only run once. This
 * checks to see if it has already run and if it has write out a kCWTaskAlreadyRun error
 * to the error pointer and then  returns NO
 *
 * @param error a NSError object to be written to if something fails
 * @return (BOOL) YES if the task has not been run, otherwise returns NO
 */
- (BOOL) _validateTaskHasRun:(NSError **)error {
    if (self.taskHasRun == YES) {
        if (*error) {
            *error = CWCreateError(kCWTaskAlreadyRun, kCWTaskErrorDomain, @"CWTask Object has already been run");
        }
        return NO;
    }
    return YES;
}

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
- (NSString *) launchTask:(NSError **)error {
    if ([self _validateTask:error] == NO) {
        return nil;
    }

    NSString * resultsString = nil;

    if (self.taskHasRun == NO) {
        [self _configureTask];
        resultsString = [self _resultsStringFromLaunchedTask];
        self.taskHasRun = YES;
        [self _performPostRunActionsIfApplicable];
    }
    return resultsString;
}

/**
 * actual launching of the task and extracting the results from
 * the NSPipe into a NSString object occur here
 *
 * @return a NSString object with the contents of the lauched tasks output
 */
- (NSString *) _resultsStringFromLaunchedTask {
    NSData * returnedData = nil;
    NSString * taskOutput = nil;

    @try {
        [cwTask launch];
    }
    @catch (NSException * e) {
        CWDebugLog(@"caught exception: %@", e);
    }

    returnedData = [[self.pipe fileHandleForReading] readDataToEndOfFile];
    if (returnedData) {
        taskOutput = [[NSString alloc] initWithData:returnedData encoding:NSUTF8StringEncoding];
    }

    return taskOutput;
}

/**
 * any post run actions after the task have been launched occurr here
 *
 * @param error a NSError object to be written to if something fails
 */
- (void) _performPostRunActionsIfApplicable {
    if (![cwTask isRunning]) {
        self.successCode = [cwTask terminationStatus];
    }
    if (self.inAsynchronous == NO && self.completionBlock) {
        self.completionBlock();
    }
}

/**
 * adds a operation to the passed in NSOperationQueue and calls
 * -launchTask: then when it is done returns back to the main
 * thread via NSOperationQueue mainQueue and executes the block
 *
 * @param queue a NSOperationQueue to launch the task on
 * @param output passed to you in the completion block with the contents of the launched tasks output
 * @param error a NSError object with a error if something went wrong
 */
- (void) launchTaskOnQueue:(NSOperationQueue *)queue
   withCompletionBlock:(void (^)(NSString * output, NSError * error))block {
    NSParameterAssert(queue);

    self.inAsynchronous = YES;

    [queue addOperationWithBlock:^{

         NSError * taskError;
         NSString * resultsString = nil;

         resultsString = [self launchTask:&taskError];

         [[NSOperationQueue mainQueue] addOperationWithBlock:^{
			 block (resultsString, taskError);
		 }];
     }];
}

/**
 * adds a operation to the passed in gcd dispatch_qeueue_t queue and calls
 * -launchTask: then when it is done returns back to the main
 * thread via dispatch_get_main_queue() and executes the block
 *
 * @param queue a Grand Central Dispatch Queue (dispatch_queue_t) to launch the task on
 * @param output passed to you in the completion block with the contents of the launched tasks output
 * @param error a NSError object with a error if something went wrong
 */
- (void) launchTaskOnGCDQueue:(dispatch_queue_t)queue
   withCompletionBlock:(void (^)(NSString * output, NSError * error))block {
    NSParameterAssert(queue);

    self.inAsynchronous = YES;

    dispatch_async(queue, ^{
		NSError * taskError;
		NSString * resultsString = nil;

		resultsString = [self launchTask:&taskError];

		dispatch_async (dispatch_get_main_queue (), ^{
			block (resultsString, taskError);
		});
	});
}

@end
