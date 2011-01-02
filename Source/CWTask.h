//
//  CWTask.h
//  Gitty
//
//  Created by Colin Wheeler on 8/30/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef void (^TaskCompletionBlock)(void);

@interface CWTask : NSObject {}

//public readonly vars
@property(nonatomic, readonly) NSString *executable;
@property(nonatomic, readonly) NSString *directoryPath;
@property(nonatomic, readonly) NSInteger successCode;
@property(nonatomic, readonly) NSArray *arguments;
//public read/write vars
@property(nonatomic, copy) TaskCompletionBlock completionBlock;

//public api
-(id)initWithExecutable:(NSString *)exec 
		   andArguments:(NSArray *)execArgs 
			atDirectory:(NSString *)path;
-(NSString *)launchTask:(NSError **)error;

@end
