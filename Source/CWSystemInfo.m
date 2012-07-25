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

+ (NSDictionary *) hostVersion
{
    SInt32 versMaj, versMin, versBugFix;

    Gestalt(gestaltSystemVersionMajor, &versMaj);
    Gestalt(gestaltSystemVersionMinor, &versMin);
    Gestalt(gestaltSystemVersionBugFix, &versBugFix);
	
	return @{	@(versMaj) : kCWSystemMajorVersion,
				@(versMin) : kCWSystemMinorVersion,
				@(versBugFix) : kCWSystemBugFixVersion };
}


+ (NSString *) hostVersionString
{
    SInt32 versMaj, versMin, versBugFix;

    Gestalt(gestaltSystemVersionMajor, &versMaj);
    Gestalt(gestaltSystemVersionMinor, &versMin);
    Gestalt(gestaltSystemVersionBugFix, &versBugFix);

    return [NSString stringWithFormat:@"%d.%d.%d", versMaj, versMin, versBugFix];
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

+(NSInteger) processorSpeed
{
	SInt32 speed;
	if (Gestalt(gestaltProcClkSpeedMHz, &speed)== noErr) {
		return (NSInteger)speed;
	}
	return 0;
}

//MARK: -
//MARK: System RAM Information

+ (NSInteger) physicalRamSize
{
    SInt32 kamount;
    if (Gestalt(gestaltPhysicalRAMSizeInMegabytes, &kamount) == noErr) {
        return (NSInteger)kamount;
    }
    return 0;
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
