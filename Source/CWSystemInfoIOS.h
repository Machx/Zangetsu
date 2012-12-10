/*
//  CWSystemInfoIOS.h
//  Zangetsu
//
//  Created by Colin Wheeler on 1/21/12.
//  Copyright (c) 2012. All rights reserved.
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
 
#import <UIKit/UIKit.h>

#define OS_VERSION_EQUALS(x) ([[[UIDevice currentDevice] systemVersion] compare:x options:NSNumericSearch] == NSOrderedSame)
#define OS_VERSION_GREATER_THAN(x) ([[[UIDevice currentDevice] systemVersion] compare:x options:NSNumericSearch] == NSOrderedDescending)
#define OS_VERSION_GREATER_OR_EQUAL_TO(x) ([[[UIDevice currentDevice] systemVersion] compare:x options:NSNumericSearch] != NSOrderedAscending) 
#define OS_VERSION_LESS_THAN(x) ([[[UIDevice currentDevice] systemVersion] compare:x options:NSNumericSearch] == NSOrderedAscending)
#define OS_VERSION_LESS_THAN_OR_EQUAL_TO(x) ([[[UIDevice currentDevice] systemVersion] compare:x options:NSNumericSearch] != NSOrderedDescending)

static NSString * const kCWSystemMajorVersion =  @"majorVersion";
static NSString * const kCWSystemMinorVersion =  @"minorVersion";
static NSString * const kCWSystemBugFixVersion = @"bugfixVersion";

@interface CWSystemInfoIOS : NSObject

/**
 Returns a NSString with the system version
 */
+(NSString *)systemVersionString;

/**
 Returns a NSDictionary with the system version broken up by section
 
 Returns a NSDictionary with the system version broken up by sections such as 
 the Major Version ("5" in "5.0.1"), Minor Version ("0" in "5.0.1") and Bugfix 
 Version ("1" in "5.0.1"). To access these you use the keys 
 kCWSystemMajorVersion, kCWSystemMinorVersion and kCWSystemBugFixVersion.
 
 @return NSDiction with host version information in keys/value pairs
 */
+(NSDictionary *)hostVersion;

/**
 Returns a NSInteger with the number of CPU Cores on the Device
 
 @return a NSInteger representing the # of CPU Cores on the current Device
 */
+(NSInteger)cpuCoreCount;

/**
 Returns a hardware model string such as 'iPad2,1' for the host system hardware
 
 @return a NSString that identifies the host system hardware model
 */
+(NSString *)hardwareModelString;

/**
 Returns a human readable string such as @"iPhone 4S" for the host hardware
 
 @return a human readable for the current host system hardware
 */
+(NSString *)englishHardwareString;

/**
 Returns a BOOL value indicating if retina is supported or not
 
 @return a BOOL indicating YES is retina resolution is supported, otherwise NO
 */
+(BOOL)retinaSupported;

@end
