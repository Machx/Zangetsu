/*
//  CWSystemInfoIOS.m
//  Zangetsu
//
//  Created by Colin Wheeler on 1/21/12.
//  Copyright (c) 2012. All rights reserved.
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
 
#import "CWSystemInfoIOS.h"

@implementation CWSystemInfoIOS

+(NSString *)systemVersionString {
	return [[UIDevice currentDevice] systemVersion];
}

+(NSDictionary *)hostVersion {
	NSMutableDictionary *versionDictionary = nil;
	NSArray *components = nil;
	components = [[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."];
	if ([components count] > 0) {
		versionDictionary = [[NSMutableDictionary alloc] initWithCapacity:3];
		
		[versionDictionary setValue:[components objectAtIndex:0] forKey:kCWSystemMajorVersion];
		[versionDictionary setValue:[components objectAtIndex:1] forKey:kCWSystemMinorVersion];
		if ([components count] == 2) {
			[versionDictionary setValue:@"0" forKey:kCWSystemBugFixVersion];
		} else {
			[versionDictionary setValue:[components objectAtIndex:2] forKey:kCWSystemBugFixVersion];
		}
	}
	return versionDictionary;
}

@end
