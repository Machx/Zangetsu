//
//  CWTask.m
//  Gitty
//
//  Created by Colin Wheeler on 8/30/10.
//  Copyright 2010. All rights reserved.
//

// LLVM 2.0+ is required to compile this file as it is

#import "CWTask.h"

@interface CWTask()
//Publicly declared
@property(nonatomic, readwrite, retain) NSString *executable;
@property(nonatomic, readwrite, retain) NSArray *arguments;
@property(nonatomic, readwrite, retain) NSString *directoryPath;
@property(nonatomic, readwrite, assign) NSInteger successCode;
//Privately Declared
@property(nonatomic, readwrite, assign) BOOL taskHasRun;
@property(nonatomic, readwrite, assign) BOOL inAsynchronous;
@end

@implementation CWTask

@synthesize executable;
@synthesize arguments;
@synthesize directoryPath;
@synthesize successCode;
@synthesize completionBlock;
@synthesize taskHasRun;
@synthesize inAsynchronous;

#pragma mark -
#pragma mark Public API

/**
 designated initializer
 */
-(id)initWithExecutable:(NSString *)exec 
		   andArguments:(NSArray *)execArgs 
			atDirectory:(NSString *)path
{
	self = [super init];
	if (self) {
		executable = exec;
		arguments = execArgs;
		directoryPath = path;
		successCode = kCWTaskNotLaunched;
		taskHasRun = NO;
		inAsynchronous = NO;
	}
	
	return self;
}

-(NSString *)description
{
	NSString * desc = [NSString stringWithFormat:@"CWTask::Executable('%@')\nArguements: %@\nDirectory Path:%@",
					   executable,arguments,directoryPath];
	
	return desc;
}

/**
 Launches the task. Uses dispatch_once() to make sure
 the task is launched only once. You can call this method directly
 yourself or implicitly via the launchTaskOnQueue* methods. In serial mode
 you can also set a completion block to fire. If launched asynchronously the
 completion block is the block you supply via parameters and the completion
 block property will not fire. I may remove the completion block entirely and
 just add a block parameter to this method.
 */
-(NSString *)launchTask:(NSError **)error
{
	NSParameterAssert(executable);
	if (![[NSFileManager defaultManager] fileExistsAtPath:self.executable]) {
		if (*error) {
			*error = CWCreateError(kCWTaskInvalidExecutable, kCWTaskErrorDomain, @"Executable Path provided doesn't exist");
		}
		return nil;
	}
	
	NSString *resultsString = nil;
	
	if (self.taskHasRun == NO) {
		
		self.taskHasRun = YES;
		
		NSTask *cwTask = [[NSTask alloc] init];
		NSPipe *pipe = [NSPipe pipe];
		NSData *returnedData = nil;
		
		[cwTask setLaunchPath:self.executable];
		[cwTask setStandardOutput:pipe];
		
		if (arguments.count > 0) {
			[cwTask setArguments:self.arguments];
		}
		if (self.directoryPath) {
			if (![[NSFileManager defaultManager] fileExistsAtPath:self.directoryPath]) {
				if (*error) {
					*error = CWCreateError(kCWTaskInvalidDirectory, kCWTaskErrorDomain, @"The Directory Specified does not exist & is invalid");
				}
				return nil;
			}
			
			[cwTask setCurrentDirectoryPath:self.directoryPath];
		}
		
		@try {
			[cwTask launch];
		}
		@catch (NSException * e) {
			CWDebugLog(@"caught exception: %@",e);
		}
		
		returnedData = [[pipe fileHandleForReading] readDataToEndOfFile];
		
		if (returnedData) {
			resultsString = [[NSString alloc] initWithData:returnedData encoding:NSUTF8StringEncoding];
		}
		
		if (![cwTask isRunning]) {
			self.successCode = [cwTask terminationStatus];
		}
		
		if (self.inAsynchronous == NO && self.completionBlock) {
			self.completionBlock();
		}
	} else {
		
		if (*error) {
			*error = CWCreateError(kCWTaskAlreadyRun,kCWTaskErrorDomain, @"CWTask Object has already been run");
			return nil;
		}
	}

	return resultsString;
}

/**
 adds a operation to the passed in NSOperationQueue and calls
 -launchTask: then when it is done returns back to the main
 thread via NSOperationQueue mainQueue and executes the block
 */
-(void)launchTaskOnQueue:(NSOperationQueue *)queue 
	 withCompletionBlock:(void (^)(NSString *output, NSError *error))block
{
	NSParameterAssert(queue);

	self.inAsynchronous = YES;
	
	[queue addOperationWithBlock:^{
		
		NSError *taskError = nil;
		NSString *resultsString = nil;
		
		resultsString = [self launchTask:&taskError];
		
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			block(resultsString,taskError);
		}];
	}];
}

/**
 adds a operation to the passed in gcd dispatch_qeueue_t queue and calls
 -launchTask: then when it is done returns back to the main
 thread via dispatch_get_main_queue() and executes the block
 */
-(void)launchTaskOnGCDQueue:(dispatch_queue_t)queue
		withCompletionBlock:(void (^)(NSString *output, NSError *error))block
{
	NSParameterAssert(queue);

	self.inAsynchronous = YES;
	
	dispatch_async(queue, ^{
		
		NSError *taskError = nil;
		NSString *resultsString = nil;
		
		resultsString = [self launchTask:&taskError];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			block(resultsString, taskError);
		});
	});
}

@end
