//
//  CWDateUtilities.h
//  NilTracker
//
//  Created by Colin Wheeler on 10/16/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>

static NSString * const kCWISO8601TimeFormat = @"yyyy/mm/dd HH:mm:ss ZZZ";
static NSString * const kCWISO8601TimeFormat2 = @"yyyy-mm-dd'T'HH:mm:ss'Z'";;

@interface CWDateUtilities : NSObject {}

+(NSDate *)dateFromISO8601String:(NSString *)dateString;

+(NSDate *)dateFromString:(NSString *)dateString withDateFormat:(NSString *)dateFormat;

@end

NSString *CWDateString(NSDate *date);

NSString *CWDateStringFromComponents(NSInteger year,NSInteger month, NSInteger day,
									 NSInteger hour,NSInteger minute, NSInteger second);
