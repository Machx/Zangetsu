//
//  CWTask.h
//  Gitty
//
//  Created by Colin Wheeler on 8/30/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CWTask : NSObject {
@private
	NSString * _executable;
	NSString * _directoryPath;
	NSTask *_internal_task;
	NSInteger _successCode;
	NSArray * _task_args;
}

-(id)initWithExecutable:(NSString *)exec 
		   andArguments:(NSArray *)execArgs 
			atDirectory:(NSString *)path;

-(NSString *) launchTaskWithError:(NSError **)error;
-(NSInteger) successCode;

@end
