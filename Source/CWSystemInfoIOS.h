/*
//  CWSystemInfoIOS.h
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
