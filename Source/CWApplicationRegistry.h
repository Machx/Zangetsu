//
//  CWApplicationRegistry.h
//  Zangetsu
//
//  Created by Colin Wheeler on 5/15/11.
//  Copyright 2011. All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSInteger kPidNotFound = -1;

@interface CWApplicationRegistry : NSObject

+(BOOL)applicationIsRunning:(NSString *)appName;
+(NSInteger)pidForApplication:(NSString *)appName;
+(NSString *)bundleIdentifierForApplication:(NSString *)appName;
+(NSInteger)executableArchitectureForApplication:(NSString *)appName;
+(NSRunningApplication *)runningAppInstanceForApp:(NSString *)appName;

@end
