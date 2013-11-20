/*
//  CWSystemInfoIOS.m
//  Zangetsu
//
//  Created by Colin Wheeler on 1/21/12.
//  Copyright (c) 2012. All rights reserved.
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
 
#import "CWSystemInfoIOS.h"
#import <sys/sysctl.h>

@implementation CWSystemInfoIOS

+(NSString *)systemVersionString {
	return [[UIDevice currentDevice] systemVersion];
}

+(NSDictionary *)hostVersion {
	NSMutableDictionary *versionDictionary = nil;
	NSArray *components = nil;
	components = [[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."];
	if (components.count > 0) {
		versionDictionary = [[NSMutableDictionary alloc] initWithCapacity:3];
		[versionDictionary addEntriesFromDictionary:@{
							 kCWSystemMajorVersion : components[0],
							 kCWSystemMinorVersion : components[1]
		 }];
		if (components.count == 2) {
			[versionDictionary addEntriesFromDictionary:@{ kCWSystemBugFixVersion : @"0" }];
		} else {
			[versionDictionary addEntriesFromDictionary:@{ kCWSystemBugFixVersion : components[2] }];
		}
	}
	return versionDictionary;
}

+(NSInteger)cpuCoreCount {
	NSInteger coreCount = 0;
    size_t size = sizeof(coreCount);
    if (sysctlbyname("hw.ncpu", &coreCount, &size, NULL, 0)) {
        return 1;
    }
    return coreCount;
}

+(NSString *)hardwareModelString {
	size_t size;
	sysctlbyname("hw.machine", NULL, &size, NULL, 0);
	char *device = calloc(1,size);
	sysctlbyname("hw.machine", device, &size, NULL, 0);
	
	NSString *deviceString = [NSString stringWithCString:device 
												encoding:NSUTF8StringEncoding];
	free(device);
	return deviceString;
}

+(NSString *)englishHardwareString {
	NSString *machineString = [CWSystemInfoIOS hardwareModelString];
	
	NSDictionary *hardwareDictionary = @{
	// iPhone ===================================
	@"iPhone2,1" : @"iPhone 3GS",
	@"iPhone3,1" : @"iPhone 4",
	@"iPhone3,3" : @"iPhone 4 (Verizon)",
	@"iPhone4,1" : @"iPhone 4S",
	@"iPhone5,1" : @"iPhone 5",
	@"iPhone5,2" : @"iPhone 5",
    @"iPhone5,3" : @"iPhone 5C",
    @"iPhone5,4" : @"iPhone 5C",
    @"iPhone6,1" : @"iPhone 5S",
    @"iPhone6,2" : @"iPhone 5S",
	// iPod Touch ===============================
	@"iPod4,1"   : @"iPod Touch (4th Generation)",
	@"iPod5,1"   : @"iPod Touch (5th Generation)",
	// iPad =====================================
	@"iPad2,1"   : @"iPad 2 (WiFi)",
	@"iPad2,2"   : @"iPad 2 (GSM)",
	@"iPad2,3"   : @"iPad 2 (CDMA)",
	@"iPad2,4"   : @"iPad 2",
	@"iPad2,5"   : @"iPad Mini (WiFi)",
	@"iPad2,6"   : @"iPad Mini (GSM)",
	@"iPad2,7"   : @"iPad Mini (GSM + CDMA)",
	@"iPad3,1"   : @"iPad 3 (WiFi)",
	@"iPad3,2"   : @"iPad 3 (4G)",
	@"iPad3,3"   : @"iPad 3 (4G)",
	@"iPad3,4"   : @"iPad 4 (WiFi)",
	@"iPad3,5"   : @"iPad 4 (GSM)",
	@"iPad3,6"   : @"iPad 4 (GSM + CDMA)",
    @"iPad4,1"   : @"iPad Air (Wifi)",
    @"iPad4,2"   : @"iPad Air (Cellular)",
    @"iPad4,4"   : @"iPad Mini 2G (Wifi)",
    @"iPad4,5"   : @"iPad Mini 2G (Cellular)",
	// iOS Simulator ============================
	@"i386"      : @"iOS Simulator",
	@"x86_64"    : @"iOS Simulator"
	};
	
	NSString *hardwareString = hardwareDictionary[machineString];
	
	return hardwareString;
}

+(BOOL)retinaSupported
{
	return ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] &&
			([UIScreen mainScreen].scale > 1.0f));
}

@end
