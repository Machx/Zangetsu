//
//  CWSystemInfo.h
//  Zangetsu
//
//  Created by Colin Wheeler on 11/14/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>

static NSString * const kCWSystemMajorVersion =  @"majorVersion";
static NSString * const kCWSystemMinorVersion =  @"minorVersion";
static NSString * const kCWSystemBugFixVersion = @"bugfixVersion";

@interface CWSystemInfo : NSObject

+(NSDictionary *)hostVersion;
+(NSString *)hostVersionString;
+(NSInteger)numberOfCPUCores;
+(NSInteger)physicalRamSize;
+(NSInteger)logicalRamSize;
+(NSInteger)processorSpeed;
@end
