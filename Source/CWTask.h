//
//  CWTask.h
//  Gitty
//
//  Created by Colin Wheeler on 8/30/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef void (^TaskCompletionBlock)(void);

/* Errors */
/* Error Domain */
static NSString * const kCWTaskErrorDomain = @"com.Zangetsu.CWTask";
/* Invalid Executable Path */
static const NSInteger kCWTaskInvalidExecutable = 1;
/* Invalid Directory specified to operate in */
static const NSInteger kCWTaskInvalidDirectory =  2;
/* Task can only be run 1 and it has already been launched */
static const NSInteger kCWTaskAlreadyRun =        3;

/* Task Code */
/* Task hasn't been launched yet */
static const NSInteger kCWTaskNotLaunched =   -1729;

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
