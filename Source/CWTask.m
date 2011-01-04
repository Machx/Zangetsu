//
//  CWTask.m
//  Gitty
//
//  Created by Colin Wheeler on 8/30/10.
//  Copyright 2010. All rights reserved.
//

#import "CWTask.h"

static const NSInteger kCWTaskNotLaunched = -1729;

@interface CWTask(Private)
//Publicly declared
@property(nonatomic, readwrite, retain) NSString *executable;
@property(nonatomic, readwrite, retain) NSArray *arguments;
@property(nonatomic, readwrite, retain) NSString *directoryPath;
@property(nonatomic, readwrite, assign) NSInteger successCode;
@end

static BOOL inAsynchronous = NO;

@implementation CWTask

@synthesize executable;
@synthesize arguments;
@synthesize directoryPath;
@synthesize successCode;
@synthesize completionBlock;

#pragma mark -
#pragma mark Public API

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
	}
	
	return self;
}

-(NSString *)launchTask:(NSError **)error
{
	NSParameterAssert(executable);
	
	static dispatch_once_t pred;
	
	__block NSTask *cwTask = [[NSTask alloc] init];
	__block NSPipe *pipe = [NSPipe pipe];
	__block NSString *resultsString = nil;
	__block NSData *returnedData = nil;
	
	dispatch_once(&pred, ^{
		[cwTask setLaunchPath:self.executable];
		[cwTask setStandardOutput:pipe];

		if (arguments.count > 0) {
			[cwTask setArguments:self.arguments];
		}
		if (self.directoryPath) {
			[cwTask setCurrentDirectoryPath:self.directoryPath];
		}

		@try {
			[cwTask launch];
		}
		@catch (NSException * e) {
			CWLog(@"caught exception: %@",e);
		}

		returnedData = [[pipe fileHandleForReading] readDataToEndOfFile];

		if (returnedData) {
			resultsString = [[NSString alloc] initWithData:returnedData encoding:NSUTF8StringEncoding];
		}

		if (![cwTask isRunning]) {
			//FIXME: should use self.successCode...
			successCode = [cwTask terminationStatus];
		}

		if (inAsynchronous == NO && self.completionBlock) {
			self.completionBlock();
		}
	});

	return resultsString;
}

-(void)launchTaskOnQueue:(NSOperationQueue *)queue 
	 withCompletionBlock:(void (^)(NSString *output, NSError *error))block
{
	inAsynchronous = YES;
	
	[queue addOperationWithBlock:^{
		
		NSError *taskError = nil;
		NSString *resultsString = nil;
		
		resultsString = [self launchTask:&taskError];
		
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			block(resultsString,taskError);
		}];
	}];
}

-(void)launchTaskOnGCDQueue:(dispatch_queue_t)queue
		withCompletionBlock:(void (^)(NSString *output, NSError *error))block
{
	inAsynchronous = YES;
	
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
