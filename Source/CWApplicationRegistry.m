//
//  CWApplicationRegistry.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/15/11.
//  Copyright 2011. All rights reserved.
//

#import "CWApplicationRegistry.h"


@implementation CWApplicationRegistry

/**
 convenience method to answer if a application is currently running
 
 @param a NSString with the app name you wish to check
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
 
 @param a NSString with the name of the app whose pid you want
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

@end
