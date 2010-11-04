/*
 *  CWTask_Private.h
 *  Gitty
 *
 *  Created by Colin Wheeler on 8/30/10.
 *  Copyright 2010. All rights reserved.
 *
 */

@interface CWTask()

@property(retain) NSString * _executable;
@property(retain) NSString * _directoryPath;
@property(retain) NSTask *_internal_task;
@property(assign) NSInteger _successCode;
@property(retain) NSArray * _task_args;

@end