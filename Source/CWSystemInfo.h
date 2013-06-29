/*
//  CWSystemInfo.h
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

#import <Foundation/Foundation.h>

#define OS_VERSION_EQUALS(x) ([[CWSystemInfo hostVersionString] compare:x options:NSNumericSearch] == NSOrderedSame)
#define OS_VERSION_GREATER_THAN(x) ([[CWSystemInfo hostVersionString] compare:x options:NSNumericSearch] == NSOrderedDescending)
#define OS_VERSION_GREATER_OR_EQUAL_TO(x) ([[CWSystemInfo hostVersionString] compare:x options:NSNumericSearch] != NSOrderedAscending)
#define OS_VERSION_LESS_THAN(x) ([[CWSystemInfo hostVersionString] compare:x options:NSNumericSearch] == NSOrderedAscending)
#define OS_VERSION_LESS_THAN_OR_EQUAL_TO(x) ([[CWSystemInfo hostVersionString] compare:x options:NSNumericSearch] != NSOrderedDescending)

static NSString * const kCWSystemMajorVersion =  @"majorVersion";
static NSString * const kCWSystemMinorVersion =  @"minorVersion";
static NSString * const kCWSystemBugFixVersion = @"bugfixVersion";

@interface CWSystemInfo : NSObject

/**
 Convenience Method to return a dictionary with the Mac OS X version information
 
 @return a NSDictionary with key/value pairs for the OS X version numbers
 */
+(NSDictionary *)hostVersion;

/**
 Convenience method to return a NSString with the Mac OS X version information.
 
 @return a string for the version of Mac OS X in use like "10.6.6"
 */
+(NSString *)hostVersionString;

/**
 Returns the number of cpu cores on the host Mac
 
 @return a NSInteger with the number of CPU cores on the Host Mac
 */
+(NSInteger)numberOfCPUCores;

/**
 Returns the amount of physical ram in Gigabytes the host device has
 
 @return a CGFloat representing the physical ram size of the host system
 */
+(CGFloat)physicalRamSize;

/**
 Returns the processor speed of the host system in Ghz as a CGFloat
 
 @return a CGFloat representing the processor speed in MHz
 */
+(CGFloat)processorSpeed;

@end
