/*
//  CWApplicationRegistry.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/15/11.
//  Copyright 2012. All rights reserved.
//
 	*/

#import "CWApplicationRegistry.h"


@implementation CWApplicationRegistry


+(BOOL)applicationIsRunning:(NSString *)appName
{
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

+(NSInteger)pidForApplication:(NSString *)appName
{
	__block NSInteger pid = kPidNotFound;
	
	NSArray *applications = [[NSWorkspace sharedWorkspace] runningApplications];
	[applications cw_each:^(id obj, NSUInteger index, BOOL *stop) {
		NSRunningApplication *app = (NSRunningApplication *)obj;
		
		if ([[app localizedName] isEqualToString:appName]) {
			pid = [app processIdentifier];
			*stop = YES;
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
			*stop = YES;
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
			*stop = YES;
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
			*stop = YES;
		}
	}];
    
    return appIcon;
}

@end
