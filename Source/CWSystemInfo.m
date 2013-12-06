/*
//  CWSystemInfo.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/14/10.
//  Copyright 2010. All rights reserved.
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

#import "CWSystemInfo.h"
#import <sys/param.h>
#import <sys/sysctl.h>


@implementation CWSystemInfo

#pragma mark Host Version Information

//private method
+(NSDictionary *)systemVersionDictionary {
	static dispatch_once_t pred;
	static NSDictionary *systemDictionary = nil;
	static NSString * const kSystemVersionPlist = @"/System/Library/CoreServices/SystemVersion.plist";
	dispatch_once(&pred,^{
		systemDictionary = [NSDictionary dictionaryWithContentsOfFile:kSystemVersionPlist];
	});
	return systemDictionary;
}

+ (NSDictionary *) hostVersion {
    NSString *systemVersionString = [CWSystemInfo hostVersionString];
	NSArray *versionComponents = [systemVersionString componentsSeparatedByString:@"."];
	
	CWAssert(versionComponents.count == 3);
	
	NSMutableDictionary *versionDictionary = [NSMutableDictionary new];
	[versionDictionary addEntriesFromDictionary:@{
	 kCWSystemMajorVersion : versionComponents[0],
	 kCWSystemMinorVersion : versionComponents[1],
	 kCWSystemBugFixVersion : versionComponents[2]
	}];
	return versionDictionary;
}


+ (NSString *) hostVersionString {
    return [CWSystemInfo systemVersionDictionary][@"ProductVersion"];
}

//The methods below this line are being considered for deprecation
//and should not be used

#pragma mark - CPU Information

+ (NSInteger) numberOfCPUCores {
    NSInteger coreCount = 0;
    size_t size = sizeof(coreCount);
    if (sysctlbyname("hw.ncpu", &coreCount, &size, NULL, 0)) {
        return 1;
    }
    return coreCount;
}

+(CGFloat) processorSpeed {
	NSUInteger hz = 0;
	size_t size = sizeof(hz);
	if (sysctlbyname("hw.cpufrequency_max", &hz, &size, NULL, 0)) {
		return 1;
	}
	return hz * 10e-10;
}

#pragma mark - System RAM Information

+ (CGFloat) physicalRamSize {
	NSUInteger bytes = 0;
	size_t size = sizeof(bytes);
	if (sysctlbyname("hw.memsize", &bytes, &size, NULL, 0)) {
		return 1;
	}
    return bytes * 9.31323e-10;
}

@end
