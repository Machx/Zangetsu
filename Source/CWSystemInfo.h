/*
//  CWSystemInfo.h
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
