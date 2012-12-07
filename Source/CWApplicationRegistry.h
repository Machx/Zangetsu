/*
//  CWApplicationRegistry.h
//  Zangetsu
//
//  Created by Colin Wheeler on 5/15/11.
//  Copyright 2012. All rights reserved.
//
 
 Copyright (c) 2012 Colin Wheeler
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import <Cocoa/Cocoa.h>

static const NSInteger kPidNotFound = -1;

@interface CWApplicationRegistry : NSObject
/**
 Returns a BOOL indicating if a given application is running
 
 Searches all the applications listed as running and if the application is 
 found then returns YES, otherwise returns NO.
 
 @param appName a NSString with the app name you wish to check
 @return a BOOL with YES if the app is running, otherwise NO
 */
+(BOOL)applicationIsRunning:(NSString *)appName;

/**
 Returns the pid for a running application
 
 Searches all the applications listed as running and if the application is 
 found then returns its pid, otherwise returns kPidNotFound (-1).
 
 @param appName a NSString with the name of the app whose pid you want
 @return a NSInteger with the pid or kPidNotFound (-1) if not found
 */
+(NSInteger)pidForApplication:(NSString *)appName;

/**
 Returns the bundle identifier for a running application
 
 Searches for all the applications listed as running and if the application is
 running then it returns the apps bundle identifier, otherwise returns nil.
 
 @param appName a NSString with the name of the application whose bundle 
 identifier you want
 @return a NSString with the bundle identifier of the app name passed in or nil 
 if the app isn't running
 */
+(NSString *)bundleIdentifierForApplication:(NSString *)appName;

/**
 Returns the NSRunningApplication instance for an App
 
 Search all the applications running and if the application is found then 
 this returns the NSRunningApplication intance corresponding to that particular
 application.
 
 @param appName a NSString with the name of the application whose corresponding 
 NSRunningApplication you want
 @return the NSRunningApplication instance corresponding to appName, else nil
 */
+(NSRunningApplication *)runningAppInstanceForApp:(NSString *)appName;

/**
 Returns the Icon for the Application corresponding to appname if its running
 
 Searches all the running applications and if it finds an application with the 
 same name returns a reference to the particular applications icon in NSImage 
 form.
 
 @param appName a NSString representing the application whose instance you want 
 its icon data
 @return a NSImage corresponding to appName, otherwise nil
 */
+(NSImage *)iconForApplication:(NSString *)appName;
@end
