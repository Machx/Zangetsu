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
	
	NSTask *cwTask = [[NSTask alloc] init];
	NSPipe *pipe = [NSPipe pipe];
	NSString *resultsString = nil;
	NSData *returnedData = nil;
	
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
	
	resultsString = [[NSString alloc] initWithData:returnedData encoding:NSUTF8StringEncoding];
	
	self.successCode = [cwTask terminationStatus];
	
	self.completionBlock();

	return resultsString;
}

@end
