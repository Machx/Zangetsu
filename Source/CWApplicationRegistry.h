/*
//  CWApplicationRegistry.h
//  Zangetsu
//
//  Created by Colin Wheeler on 5/15/11.
//  Copyright 2012. All rights reserved.
//
 
 Copyright (c) 2013, Colin Wheeler
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 - Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <Cocoa/Cocoa.h>

static const NSInteger kPidNotFound = -1;

@interface CWApplicationRegistry : NSObject
/**
 Returns a BOOL indicating if a given application is running
 
 Searches all the applications listed as running and if the application is 
 found then returns YES, otherwise returns NO.
 
 @param appName the name of the application to be checked if it's running
 @return a BOOL with YES if the app is running, otherwise NO
 */
+(BOOL)applicationIsRunning:(NSString *)appName;

/**
 Returns the pid for a running application
 
 Searches all the applications listed as running and if the application is 
 found then returns its pid, otherwise returns kPidNotFound (-1).
 
 @param appName the name of the app whose pid you want
 @return a NSInteger with the pid or kPidNotFound (-1) if not found
 */
+(NSInteger)pidForApplication:(NSString *)appName;

/**
 Returns the bundle identifier for a running application
 
 Searches for all the applications listed as running and if the application is
 running then it returns the apps bundle identifier, otherwise returns nil.
 
 @param appName the name of the application whose bundle identifier you want
 @return a NSString of the bundle identifier of the app name passed in or nil
 */
+(NSString *)bundleIdentifierForApplication:(NSString *)appName;

/**
 Returns the NSRunningApplication instance for an App
 
 Search all the applications running and if the application is found then 
 this returns the NSRunningApplication intance corresponding to that particular
 application.
 
 @param appName the name of the application whose instance you want
 @return the NSRunningApplication instance corresponding to appName, else nil
 */
+(NSRunningApplication *)runningAppInstanceForApp:(NSString *)appName;

@end
