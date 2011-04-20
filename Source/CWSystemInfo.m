//
//  CWSystemInfo.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/14/10.
//  Copyright 2010. All rights reserved.
//

#import "CWSystemInfo.h"
#import <sys/param.h>
#import <sys/sysctl.h>


@implementation CWSystemInfo

/**
 Convenience Method to return a dictionary with the Mac OS X version
 information in a way where you can query a specific part of the version
 information you want
 
 @return hostVersion a NSDictionary with the key/value pairs for the majaor/minor/bugfix version #'s of Mac OS X
 */
+(NSDictionary *)hostVersion
{
	SInt32 versMaj, versMin, versBugFix;
	
	Gestalt(gestaltSystemVersionMajor, &versMaj);
	Gestalt(gestaltSystemVersionMinor, &versMin);
	Gestalt(gestaltSystemVersionBugFix, &versBugFix);
	
	return NSDICT([NSNumber numberWithLong:versMaj],    kCWSystemMajorVersion,
				  [NSNumber numberWithLong:versMin],    kCWSystemMinorVersion,
				  [NSNumber numberWithLong:versBugFix], kCWSystemBugFixVersion);
}

/**
 Convenience method to return a NSString with the Mac OS X version 
 information.
 
 @return hostVersionString a string for the version of Mac OS X in use like "10.6.6" for Mac OS X 10.6.6
 */
+(NSString *)hostVersionString
{
	SInt32 versMaj, versMin, versBugFix;
	
	Gestalt(gestaltSystemVersionMajor, &versMaj);
	Gestalt(gestaltSystemVersionMinor, &versMin);
	Gestalt(gestaltSystemVersionBugFix, &versBugFix);
	
	return [NSString stringWithFormat:@"%d.%d.%d",versMaj,versMin,versBugFix];
}

/**
 Does what it says it does, returns the # of cpu cores on the host Mac
 
 @return numberOfCUPCores a NSInteger with the number of CPU cores on the Host Mac
 */
+(NSInteger)numberOfCPUCores
{
	NSInteger coreCount = 0;
	size_t size = sizeof(coreCount);
	
	if( sysctlbyname("hw.ncpu", &coreCount, &size, NULL, 0) ){
		return 1;
	}
	
	return coreCount;
}

+(NSInteger)physicalRamSize {
	SInt32 kamount;
	
	if (Gestalt(gestaltPhysicalRAMSizeInMegabytes, &kamount) == noErr) {
		return (NSInteger)kamount;
	}
	
	return 0;
}

+(NSInteger)logicalRamSize {
	SInt32 kamount;
	
	if (Gestalt(gestaltLogicalRAMSize, &kamount) == noErr) {
		return (NSInteger)kamount;
	}
	
	return 0;
}

@end
