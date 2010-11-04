//
//  CWTask.m
//  Gitty
//
//  Created by Colin Wheeler on 8/30/10.
//  Copyright 2010. All rights reserved.
//

#import "CWTask.h"
#import "CWTask_Private.h"

@implementation CWTask

@synthesize _executable;
@synthesize _directoryPath;
@synthesize _internal_task;
@synthesize _successCode;
@synthesize _task_args;

-(id)initWithExecutable:(NSString *)exec 
		   andArguments:(NSArray *)execArgs 
			atDirectory:(NSString *)path
{
	self = [super init];
	if(self){
		_internal_task = [[NSTask alloc] init];
		_directoryPath = path;
		_executable = exec;
		_successCode = 0;
		_task_args = execArgs;
	}
	
	return self;
}

-(NSString *) launchTaskWithError:(NSError **)error;
{
	NSParameterAssert(self._internal_task);
	
	if(self._executable == nil){
		NSAssert(0,@"CWTask Executable is Nil! Exiting...");
		*error = [NSError errorWithDomain:@"CWTask Domain"
									 code:1
								 userInfo:nil];
		return nil;
	}
	
	NSPipe *_taskPipe = [NSPipe pipe];
	NSData *_returned_data = nil;
	
	[self._internal_task setStandardOutput:_taskPipe];
	[self._internal_task setArguments:self._task_args];
	[self._internal_task setLaunchPath:self._executable];
	if(self._directoryPath){
		[self._internal_task setCurrentDirectoryPath:self._directoryPath];
	}
	
	CWLog(@"CWTask: %@",self._internal_task);
	
	@try{
		[self._internal_task launch];
	}@catch(NSException * e){
		CWLog(@"Caught Exception: %@",e);
	}
	
	_returned_data = [[NSData alloc] initWithData:[[_taskPipe fileHandleForReading] readDataToEndOfFile]];
	
	self._successCode = [self._internal_task terminationStatus];
	
	NSString * returnedString = nil;
	
	if(_returned_data != nil){
		returnedString = [[NSString alloc] initWithData:_returned_data
											   encoding:NSUTF8StringEncoding];
	}
	
	return returnedString;
}

-(NSInteger) successCode
{
	return self._successCode;
}

@end
