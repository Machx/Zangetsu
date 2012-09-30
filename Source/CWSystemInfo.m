/*
//  CWSystemInfo.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/14/10.
//  Copyright 2010. All rights reserved.
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

#import "CWSystemInfo.h"
#import <sys/param.h>
#import <sys/sysctl.h>


@implementation CWSystemInfo

//MARK: -
//MARK: Host Version Information

//private method
+(NSDictionary *)systemVersionDictionary
{
	static dispatch_once_t pred;
	static NSDictionary *systemDictionary = nil;
	static NSString * const kSystemVersionPlist = @"/System/Library/CoreServices/SystemVersion.plist";
	
	dispatch_once(&pred,^{
		systemDictionary = [NSDictionary dictionaryWithContentsOfFile:kSystemVersionPlist];
	});
	
	return systemDictionary;
}

+ (NSDictionary *) hostVersion
{
    NSString *systemVersionString = [CWSystemInfo hostVersionString];
	NSArray *versionComponents = [systemVersionString componentsSeparatedByString:@"."];
	
	NSAssert(versionComponents.count == 3, nil);
	
	NSMutableDictionary *versionDictionary = [NSMutableDictionary new];
	[versionDictionary addEntriesFromDictionary:@{
	 kCWSystemMajorVersion : versionComponents[0],
	 kCWSystemMinorVersion : versionComponents[1],
	 kCWSystemBugFixVersion : versionComponents[2]
	}];
	
	return versionDictionary;
}


+ (NSString *) hostVersionString
{
    return [CWSystemInfo systemVersionDictionary][@"ProductVersion"];
}

//MARK: -
//MARK: CPU System Information

+ (NSInteger) numberOfCPUCores
{
    NSInteger coreCount = 0;
    size_t size = sizeof(coreCount);
    if ( sysctlbyname("hw.ncpu", &coreCount, &size, NULL, 0) ) {
        return 1;
    }
    return coreCount;
}

+(CGFloat) processorSpeed
{
	NSUInteger hz = 0;
	size_t size = sizeof(hz);
	if ( sysctlbyname("hw.cpufrequency_max", &hz, &size, NULL, 0) ) {
		return 1;
	}
	return hz * 10e-10;
}

//MARK: -
//MARK: System RAM Information

+ (CGFloat) physicalRamSize
{
	NSUInteger bytes = 0;
	size_t size = sizeof(bytes);
	if ( sysctlbyname("hw.memsize", &bytes, &size, NULL, 0) ) {
		return 1;
	}
    return bytes * 9.31323e-10;
}

+ (NSInteger) logicalRamSize
{
    SInt32 kamount;
    if (Gestalt(gestaltLogicalRAMSize, &kamount) == noErr) {
        NSInteger amount = (((NSInteger)kamount / 1024) / 1024);
        return amount;
    }
    return 0;
}

@end
