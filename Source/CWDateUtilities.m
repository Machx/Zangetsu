//
//  CWDateUtilities.m
//  NilTracker
//
//  Created by Colin Wheeler on 10/16/10.
//  Copyright 2010. All rights reserved.
//

#import "CWDateUtilities.h"

@implementation CWDateUtilities

/**
 Experimental method for parsing ISO8601 Strings given usually when 
 XML data is given back
 */
+(NSDate *)dateFromISO8601String:(NSString *)dateString
{
	return [self dateFromString:dateString withDateFormat:kCWISO8601TimeFormat];
}

/**
 Convenience Method to quickly return a NSDate object from a date
 string with a specified date format
 */
+(NSDate *)dateFromString:(NSString *)dateString withDateFormat:(NSString *)dateFormat
{
	[NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:dateFormat];
	
	NSDate *returnedDate = [formatter dateFromString:dateString];
	
	return returnedDate;
}

@end
