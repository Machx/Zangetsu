//
//  CWDateUtilities.h
//  NilTracker
//
//  Created by Colin Wheeler on 10/16/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define kCWISO8601TimeFormat @"yyyy/mm/dd HH:mm:ss ZZZ"

@interface CWDateUtilities : NSObject {}

+(NSDate *)dateFromISO8601String:(NSString *)dateString;

+(NSDate *)dateFromString:(NSString *)dateString withDateFormat:(NSString *)dateFormat;

@end
