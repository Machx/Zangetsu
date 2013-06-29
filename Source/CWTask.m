/*
//  CWTask.m
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

#import "CWTask.h"
#import "EXTScope.h"

@interface CWTask ()
// Publicly declared
@property (readwrite, copy) NSString * executable;
@property (readwrite, retain) NSArray * arguments;
@property (readwrite, copy) NSString * directoryPath;
@property (readwrite, assign) NSInteger successCode;
// Privately Declared
@property (readwrite, assign) BOOL taskHasRun;
@property (readwrite, assign) BOOL inAsynchronous;
@property (readwrite, retain) NSPipe * pipe;
@property (readwrite, retain) NSTask * internalTask;
@end

@implementation CWTask

#pragma mark Public API -

- (id) initWithExecutable:(NSString *)exec
			 andArguments:(NSArray *)execArgs
			  atDirectory:(NSString *)path {
    self = [super init];
    if (self) {
		_executable = exec;
		_arguments = execArgs;
		_directoryPath = path;
		_successCode = kCWTaskNotLaunchedErrorCode;
		_taskHasRun = NO;
		_inAsynchronous = NO;
		_internalTask = [[NSTask alloc] init];
		_completionBlock = nil;
    }
    return self;
}

/**
 default implementation so if someone calls this and then
 tries to launch the task the method will immediately see
 that executable == nil and therefore will return immediatly
 with an error about the executable.
 
 @return an invalid CWTask object
 */
- (id) init {
    self = [super init];
    if (self) {
		_executable = nil;
		_arguments = nil;
		_directoryPath = nil;
		_successCode = kCWTaskNotLaunchedErrorCode;
		_taskHasRun = NO;
		_inAsynchronous = NO;
		_internalTask = nil;
		_completionBlock = nil;
    }
    return self;
}

/**
 * Description for debug information
 */
- (NSString *) description {
    return [NSString stringWithFormat:@"CWTask::Executable('%@')\nArguements: %@\nDirectory Path:%@",
			self.executable, self.arguments, self.directoryPath];
}

/**
 Private Method
 Any arguments to the task are set here
 */
- (void) _configureTask {
	self.internalTask.launchPath = self.executable;
	self.pipe = [NSPipe pipe];
	self.internalTask.standardOutput = self.pipe;
	if (self.arguments.count > 0) {
		self.internalTask.arguments = self.arguments;
	}
	if (self.directoryPath) {
		self.internalTask.currentDirectoryPath = self.directoryPath;
	}
}

/**
 Private Method
 Runs all the validation methods and returns NO if any of them fail,
 returns YES otherwise
 
 @param error a NSError object to be written to if something fails
 @return (BOOL) NO if the task fails any validation test, YES otherwise
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
 Private Method
 Checks for a non nil value of executable and checks that the executable
 actually exists if either fail it writes out a kCWTaskInvalidExecutable error
 to the NSError pointer and returns NO
 
 @param error a NSError object to be written to if something fails
 @return (BOOL) NO is the executable specified doesn't exist otherwise YES
 */
- (BOOL) _validateExecutable:(NSError **)error {
    if ((!self.executable) || ![[NSFileManager defaultManager] fileExistsAtPath:self.executable]) {
		if (error) {
			*error = [NSError errorWithDomain:kCWTaskErrorDomain
										 code:kCWTaskInvalidExecutableErrorCode
									 userInfo:@{ NSLocalizedFailureReasonErrorKey : @"Executable Path provided doesn't exist" }];
		}
        return NO;
    }
    return YES;
}

/**
 Private Method
 if there is a non nil directory path provided it validates that it actually 
 exists if that fails it writes out a kCWTaskInvalidDirectory error & returns NO
 
 @param error a NSError object to be written to if something fails
 @return (BOOL) YES if the directory path exists otherwise returns NO
 */
- (BOOL) _validateDirectoryPathIfApplicable:(NSError **)error {
    if (self.directoryPath) {
        if (![[NSFileManager defaultManager] fileExistsAtPath:self.directoryPath]) {
			if (error) {
				*error = [NSError errorWithDomain:kCWTaskErrorDomain
											 code:kCWTaskInvalidDirectoryErrorCode
										 userInfo:@{ NSLocalizedFailureReasonErrorKey : @"The Directory Specified does not exist & is invalid" }];
			}
            return NO;
        }
    }
    return YES;
}

/**
 Private Method
 CWTask behaves just like  NSTask in that each task object may only run once. 
 This checks to see if it has already run and if it has write out a 
 kCWTaskAlreadyRun error to the error pointer and then  returns NO
 
 @param error a NSError object to be written to if something fails
 @return (BOOL) YES if the task has not been run, otherwise returns NO
 */
- (BOOL) _validateTaskHasRun:(NSError **)error {
    if (self.taskHasRun) {
		if (error) {
			*error = [NSError errorWithDomain:kCWTaskErrorDomain
										 code:kCWTaskAlreadyRunErrorCode
									 userInfo:@{ NSLocalizedFailureReasonErrorKey: @"This CWTask Instance has already been run" }];
		}
        return NO;
    }
    return YES;
}

- (NSString *) launchTask:(NSError **)error {
    if (![self _validateTask:error]) return nil;
	
    NSString * resultsString = nil;
	if (!self.taskHasRun) {
		[self _configureTask];
		resultsString = [self _resultsStringFromLaunchedTask:error];
		self.taskHasRun = YES;
		[self _performPostRunActionsIfApplicable];
	}
    return resultsString;
}

/**
 Private Method
 actual launching of the task and extracting the results from
 the NSPipe into a NSString object occur here
 
 @return a NSString object with the contents of the lauched tasks output
 */
- (NSString *) _resultsStringFromLaunchedTask:(NSError **)error {
    NSData * returnedData = nil;
    NSString * taskOutput = nil;

    @try {
        [self.internalTask launch];
    }
    @catch (NSException * e) {
		CWLogInfo(@"caught exception: %@",e);
		if (error) {
			*error = [NSError errorWithDomain:kCWTaskErrorDomain
										 code:kCWTaskEncounteredExceptionOnRunErrorCode
									 userInfo:@{ NSLocalizedFailureReasonErrorKey : [e description] }];
		}
    }

    returnedData = [[self.pipe fileHandleForReading] readDataToEndOfFile];
    if (returnedData) {
        taskOutput = [[NSString alloc] initWithData:returnedData 
										   encoding:NSUTF8StringEncoding];
    }
    return taskOutput;
}

/**
 Private Method
 any post run actions after the task have been launched occurr here
 
 @param error a NSError object to be written to if something fails
 */
- (void) _performPostRunActionsIfApplicable {
    if (!self.internalTask.isRunning) {
		self.successCode = self.internalTask.terminationStatus;
    }
	if ((!self.inAsynchronous) && self.completionBlock) {
		self.completionBlock();
	}
}

-(void)launchTaskWithResult:(void (^)(NSString *output, NSError *error))block {
	NSString *uLabel = [NSString stringWithFormat:@"com.CWTask.%@_",self.executable];
	const char *uniqueLabel = [CWUUIDStringPrependedWithString(uLabel) UTF8String];
	dispatch_queue_t queue = dispatch_queue_create(uniqueLabel, DISPATCH_QUEUE_SERIAL);
	self.inAsynchronous = YES;
	@weakify(self);
	dispatch_async(queue, ^{
		@strongify(self);
		NSError * taskError;
		NSString * resultsString = nil;
		
		resultsString = [self launchTask:&taskError];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			block(resultsString, taskError);
		});
	});
	dispatch_release(queue);
}

- (void) launchTaskOnQueue:(NSOperationQueue *)queue 
	   withCompletionBlock:(void (^)(NSString * output, NSError * error))block {
	CWAssert(queue != nil);
	self.inAsynchronous = YES;
	@weakify(self);
    [queue addOperationWithBlock:^{
		@strongify(self);
		NSError * taskError;
		NSString * resultsString = nil;
		
		resultsString = [self launchTask:&taskError];
		
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			block (resultsString, taskError);
		}];
     }];
}

- (void) launchTaskOnGCDQueue:(dispatch_queue_t)queue
		  withCompletionBlock:(void (^)(NSString * output, NSError * error))block {
	CWAssert(queue != nil);
	self.inAsynchronous = YES;
	@weakify(self);
    dispatch_async(queue, ^{
		@strongify(self);
		NSError * taskError;
		NSString * resultsString = nil;

		resultsString = [self launchTask:&taskError];

		dispatch_async (dispatch_get_main_queue (), ^{
			block (resultsString, taskError);
		});
	});
}

@end
