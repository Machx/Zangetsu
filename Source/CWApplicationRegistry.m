/*
//  CWApplicationRegistry.m
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

#import "CWApplicationRegistry.h"


@implementation CWApplicationRegistry


+(BOOL)applicationIsRunning:(NSString *)appName {
	if ([CWApplicationRegistry runningApplicationInstanceForAppName:appName] != nil) {
		return YES;
	}
	return NO;
}

+(NSInteger)pidForApplication:(NSString *)appName {
	NSInteger pid = kPidNotFound;
	
	NSRunningApplication *app = [self runningApplicationInstanceForAppName:appName];
	if (app) pid = app.processIdentifier;
	
	return pid;
}

+(NSString *)bundleIdentifierForApplication:(NSString *)appName {
	NSRunningApplication *app = [CWApplicationRegistry runningApplicationInstanceForAppName:appName];
	if (app) return app.bundleIdentifier;
	
	return nil;
}

+(NSRunningApplication *)runningApplicationInstanceForAppName:(NSString *)appName {
    NSArray *applications = [[NSWorkspace sharedWorkspace] runningApplications];
	
	NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
		NSRunningApplication *app = (NSRunningApplication *)evaluatedObject;
		if ([[app localizedName] isEqualToString:appName]) return YES;
		
		return NO;
	}];
	
	NSArray *results = [applications filteredArrayUsingPredicate:predicate];
	if (results.count > 0) return results[0];
    
	return nil;
}

@end
