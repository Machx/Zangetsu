//
//  CWTask.h
//  Gitty
//
//  Created by Colin Wheeler on 8/30/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CWTask : NSObject {}

//public vars
@property(nonatomic, readonly) NSString *executable;
@property(nonatomic, readonly) NSString *directoryPath;
@property(nonatomic, readonly) NSInteger successCode;
@property(nonatomic, readonly) NSArray *arguments;

//public api
-(id)initWithExecutable:(NSString *)exec 
		   andArguments:(NSArray *)execArgs 
			atDirectory:(NSString *)path;
-(NSString *)launchTask:(NSError **)error;

@end
