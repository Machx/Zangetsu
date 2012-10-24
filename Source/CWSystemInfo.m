/*
//  CWSystemInfo.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/14/10.
//  Copyright 2010. All rights reserved.
//
 
 */

#import "CWSystemInfo.h"
#import <sys/param.h>
#import <sys/sysctl.h>


@implementation CWSystemInfo

#pragma mark Host Version Information

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

#pragma mark - CPU Information

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

#pragma mark - System RAM Information

+ (CGFloat) physicalRamSize
{
	NSUInteger bytes = 0;
	size_t size = sizeof(bytes);
	if ( sysctlbyname("hw.memsize", &bytes, &size, NULL, 0) ) {
		return 1;
	}
    return bytes * 9.31323e-10;
}

@end
