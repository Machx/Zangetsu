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
 XML data is given back. This method now tries to use a standard format
 for trying to extract a date from the string. If the 1st ISO8601 format
 does not work then it will try to use a 2nd variation before finally
 giving up all together. In the short term this will work, however in the
 long run I'll need to design something to parse a date string and return
 a date based on the information given.
 */
+(NSDate *)dateFromISO8601String:(NSString *)dateString
{
	NSDate *isoDate = nil;
	
	isoDate = [self dateFromString:dateString withDateFormat:kCWISO8601TimeFormat];
	if(isoDate == nil)
		isoDate = [self dateFromISO8601String:kCWISO8601TimeFormat2];
	
	return isoDate;
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
