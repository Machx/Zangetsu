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


+(BOOL)applicationIsRunning:(NSString *)appName
{
	__block BOOL isRunning = NO;
	NSArray *applications = [[NSWorkspace sharedWorkspace] runningApplications];
	
	[applications cw_eachConcurrentlyWithBlock:^(id obj, NSUInteger index, BOOL *stop) {
		if ([[obj localizedName] isEqualToString:appName]) {
			isRunning = YES;
			*stop = YES;
		}
	}];
	return isRunning;
}

+(NSInteger)pidForApplication:(NSString *)appName
{
	__block NSInteger pid = kPidNotFound;
	
	NSArray *applications = [[NSWorkspace sharedWorkspace] runningApplications];
	[applications cw_each:^(id obj, NSUInteger index, BOOL *stop) {
		NSRunningApplication *app = (NSRunningApplication *)obj;
		
		if ([[app localizedName] isEqualToString:appName]) {
			pid = [app processIdentifier];
		}
	}];
	return pid;
}

+(NSString *)bundleIdentifierForApplication:(NSString *)appName
{
	__block NSString *bundleIdentifier = nil;
	NSArray *applications = [[NSWorkspace sharedWorkspace] runningApplications];
	[applications cw_each:^(id obj, NSUInteger index, BOOL *stop) {
		NSRunningApplication *app = (NSRunningApplication *)obj;
		
		if ([[app localizedName] isEqualToString:appName]) {
			bundleIdentifier = [app bundleIdentifier];
		}
	}];
	return bundleIdentifier;
}

+(NSRunningApplication *)runningAppInstanceForApp:(NSString *)appName
{
    __block NSRunningApplication *appInstance = nil;
    NSArray *applications = [[NSWorkspace sharedWorkspace] runningApplications];
	[applications cw_each:^(id obj, NSUInteger index, BOOL *stop) {
		NSRunningApplication *app = (NSRunningApplication *)obj;
		
		if ([[app localizedName] isEqualToString:appName]) {
			appInstance = app;
		}
	}];
    return appInstance;
}

+(NSImage *)iconForApplication:(NSString *)appName 
{    
    __block NSImage *appIcon = nil;
    NSArray *applications = [[NSWorkspace sharedWorkspace] runningApplications];
	
	[applications cw_each:^(id obj, NSUInteger index, BOOL *stop) {
		NSRunningApplication *app = (NSRunningApplication *)obj;
		
		if ([[app localizedName] isEqualToString:appName]) {
			appIcon = [app icon];
		}
	}];
    
    return appIcon;
}

@end
