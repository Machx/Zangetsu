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
 */
+(NSString *)hostVersionString
{
	SInt32 versMaj, versMin, versBugFix;
	
	Gestalt(gestaltSystemVersionMajor, &versMaj);
	Gestalt(gestaltSystemVersionMinor, &versMin);
	Gestalt(gestaltSystemVersionBugFix, &versBugFix);
	
	return [NSString stringWithFormat:@"%d.%d.%d",versMaj,versMin,versBugFix];
}

+(NSInteger)numberOfCPUCores
{
	NSInteger coreCount = 0;
	size_t size = sizeof(coreCount);
	
	if( sysctlbyname("hw.ncpu", &coreCount, &size, NULL, 0) ){
		return 1;
	}
	
	return coreCount;
}

@end
