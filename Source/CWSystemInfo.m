/*
//  CWSystemInfo.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/14/10.
//  Copyright 2010. All rights reserved.
//
 
 Copyright (c) 2011 Colin Wheeler
 
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

/**
 * Convenience Method to return a dictionary with the Mac OS X version
 * information in a way where you can query a specific part of the version
 * information you want
 *
 * @return hostVersion a NSDictionary with the key/value pairs for the majaor/minor/bugfix version #'s of Mac OS X
 */
+ (NSDictionary *) hostVersion {
    SInt32 versMaj, versMin, versBugFix;

    Gestalt(gestaltSystemVersionMajor, &versMaj);
    Gestalt(gestaltSystemVersionMinor, &versMin);
    Gestalt(gestaltSystemVersionBugFix, &versBugFix);

    return NSDICT([NSNumber numberWithLong:versMaj],    kCWSystemMajorVersion,
                  [NSNumber numberWithLong:versMin],    kCWSystemMinorVersion,
                  [NSNumber numberWithLong:versBugFix], kCWSystemBugFixVersion);
}

/**
 * Convenience method to return a NSString with the Mac OS X version
 * information.
 *
 * @return hostVersionString a string for the version of Mac OS X in use like "10.6.6" for Mac OS X 10.6.6
 */
+ (NSString *) hostVersionString {
    SInt32 versMaj, versMin, versBugFix;

    Gestalt(gestaltSystemVersionMajor, &versMaj);
    Gestalt(gestaltSystemVersionMinor, &versMin);
    Gestalt(gestaltSystemVersionBugFix, &versBugFix);

    return [NSString stringWithFormat:@"%d.%d.%d", versMaj, versMin, versBugFix];
}

//MARK: -
//MARK: CPU System Information

/**
 * Does what it says it does, returns the # of cpu cores on the host Mac
 *
 * @return numberOfCUPCores a NSInteger with the number of CPU cores on the Host Mac
 */
+ (NSInteger) numberOfCPUCores {
    NSInteger coreCount = 0;
    size_t size = sizeof(coreCount);
    if ( sysctlbyname("hw.ncpu", &coreCount, &size, NULL, 0) ) {
        return 1;
    }
    return coreCount;
}

/**
 * Returns the processor speed of the host system in MHz as a NSInteger
 * 
 * @return a NSInteger representing the processor speed in MHz
 */
+(NSInteger) processorSpeed {
	SInt32 speed;
	if (Gestalt(gestaltProcClkSpeedMHz, &speed)== noErr) {
		return (NSInteger)speed;
	}
	return 0;
}

//MARK: -
//MARK: System RAM Information

/**
 * Returns the amount of physical ram in megabytes the host device has
 *
 * @return a NSInteger representing the physical ram size of the host system
 */
+ (NSInteger) physicalRamSize {
    SInt32 kamount;
    if (Gestalt(gestaltPhysicalRAMSizeInMegabytes, &kamount) == noErr) {
        return (NSInteger)kamount;
    }
    return 0;
}

/**
 * Returns the amount of logical ram in megabytes the host device has. This
 * may be less than the physical ram size because things like the OS/gpu
 * may be using some of the physical ram.
 * 
 * @return a NSInteger representing the logical ram size of the host system
 */
+ (NSInteger) logicalRamSize {
    SInt32 kamount;
    if (Gestalt(gestaltLogicalRAMSize, &kamount) == noErr) {
        NSInteger amount = (((NSInteger)kamount / 1024) / 1024);
        return amount;
    }
    return 0;
}

@end
