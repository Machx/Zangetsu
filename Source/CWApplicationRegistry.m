/*
//  CWApplicationRegistry.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/15/11.
//  Copyright 2011. All rights reserved.
//
 
 Copyright (c) 2011 Colin Wheeler
 
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

#import "CWApplicationRegistry.h"


@implementation CWApplicationRegistry

/**
 convenience method to answer if a application is currently running
 
 @param appName a NSString with the app name you wish to check
 @return a BOOL with YES if the app is running, otherwise NO
 */
+(BOOL)applicationIsRunning:(NSString *)appName {
	BOOL isRunning = NO;
	NSArray *applications = [[NSWorkspace sharedWorkspace] runningApplications];
	
	isRunning = [applications cw_isObjectInArrayWithBlock:^BOOL(id obj) {
		if ([[obj localizedName] isEqualToString:appName]) {
			return YES;
		}
		return NO;
	}];
	
	return isRunning;
}


/**
 convenience method to get the pid for a running application
 
 @param appName a NSString with the name of the app whose pid you want
 @return a NSInteger with the pid or kPidNotFound (-1) if not found
 */
+(NSInteger)pidForApplication:(NSString *)appName {
	__block NSInteger pid = kPidNotFound;
	
	NSArray *applications = [[NSWorkspace sharedWorkspace] runningApplications];
	[applications cw_each:^(id obj){
		NSRunningApplication *app = (NSRunningApplication *)obj;
		
		if ([[app localizedName] isEqualToString:appName]) {
			pid = [app processIdentifier];
		}
	}];
	
	return pid;
}

/**
 returns the bundle identifier for a running application
 
 @param appName a NSString with the name of the application whose bundle identifier you want
 @return a NSString with the bundle identifier of the app name passed in or nil if the app isn't running
 */
+(NSString *)bundleIdentifierForApplication:(NSString *)appName {
	__block NSString *bundleIdentifier = nil;
	
	NSArray *applications = [[NSWorkspace sharedWorkspace] runningApplications];
	[applications cw_each:^(id obj){
		NSRunningApplication *app = (NSRunningApplication *)obj;
		
		if ([[app localizedName] isEqualToString:appName]) {
			bundleIdentifier = [app bundleIdentifier];
		}
	}];
	
	return bundleIdentifier;
}

+(NSInteger)executableArchitectureForApplication:(NSString *)appName {
    __block NSInteger architecture = 0;
    
    NSArray *applications = [[NSWorkspace sharedWorkspace] runningApplications];
	[applications cw_each:^(id obj){
		NSRunningApplication *app = (NSRunningApplication *)obj;
		
		if ([[app localizedName] isEqualToString:appName]) {
			architecture = [app executableArchitecture];
		}
	}];
    
    return  architecture;
}

+(NSRunningApplication *)runningAppInstanceForApp:(NSString *)appName {
    __block NSRunningApplication *appInstance = nil;
    
    NSArray *applications = [[NSWorkspace sharedWorkspace] runningApplications];
	[applications cw_each:^(id obj){
		NSRunningApplication *app = (NSRunningApplication *)obj;
		
		if ([[app localizedName] isEqualToString:appName]) {
			appInstance = app;
		}
	}];
    
    return appInstance;
}

+(NSImage *)iconForApplication:(NSString *)appName {
    
    __block NSImage *appIcon = nil;
    
    NSArray *applications = [[NSWorkspace sharedWorkspace] runningApplications];
	[applications cw_each:^(id obj){
		NSRunningApplication *app = (NSRunningApplication *)obj;
		
		if ([[app localizedName] isEqualToString:appName]) {
			appIcon = [app icon];
		}
	}];
    
    return appIcon;
}

@end
