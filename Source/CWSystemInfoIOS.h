/*
//  CWSystemInfoIOS.h
//  Zangetsu
//
//  Created by Colin Wheeler on 1/21/12.
//  Copyright (c) 2012. All rights reserved.
//
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
 Returns a NSString with the system version	*/
+(NSString *)systemVersionString;

/**
 Returns a NSDictionary with the system version broken up by section
 
<<<<<<< HEAD
 Returns a NSDictionary with the system version broken up by sections such as the
 Major Version ("5" in "5.0.1"), Minor Version ("0" in "5.0.1") and Bugfix Version
 ("1" in "5.0.1"). To access these you use the keys kCWSystemMajorVersion,
 kCWSystemMinorVersion and kCWSystemBugFixVersion. 	*/
=======
 Returns a NSDictionary with the system version broken up by sections such as 
 the Major Version ("5" in "5.0.1"), Minor Version ("0" in "5.0.1") and Bugfix 
 Version ("1" in "5.0.1"). To access these you use the keys 
 kCWSystemMajorVersion, kCWSystemMinorVersion and kCWSystemBugFixVersion.
 
 @return NSDiction with host version information in keys/value pairs
 */
>>>>>>> upstream/master
+(NSDictionary *)hostVersion;

/**
 Returns a NSInteger with the number of CPU Cores on the Device
 
 @return a NSInteger representing the # of CPU Cores on the current Device	*/
+(NSInteger)cpuCoreCount;

/**
 Returns a hardware model string such as 'iPad2,1' for the host system hardware
 
<<<<<<< HEAD
 @return a NSString that identifies the hardware that the code is being executed on	*/
=======
 @return a NSString that identifies the host system hardware model
 */
>>>>>>> upstream/master
+(NSString *)hardwareModelString;

/**
 Returns a human readable string such as @"iPhone 4S" for the host hardware
 
<<<<<<< HEAD
 @return a human readable string such 'iPhone 4S' that identifies the hardware this code is being run on	*/
=======
 @return a human readable for the current host system hardware
 */
>>>>>>> upstream/master
+(NSString *)englishHardwareString;

/**
 Returns a BOOL value indicating if retina is supported or not
 
<<<<<<< HEAD
 @return a BOOL indicating YES is retina resolution is supported on the current hardware, otherwise NO	*/
=======
 @return a BOOL indicating YES is retina resolution is supported, otherwise NO
 */
>>>>>>> upstream/master
+(BOOL)retinaSupported;

@end
