//
//  CWDateUtilities.m
//  NilTracker
//
//  Created by Colin Wheeler on 10/16/10.
//  Copyright 2010. All rights reserved.
//

#import "CWDateUtilities.h"


@implementation CWDateUtilities

//
// Experimental method for parsing ISO8601 Strings given usually when 
// XML data is given back
//
+(NSDate *)dateFromISO8601String:(NSString *)dateString
{
	[NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-mm-dd'T'hh:mm:ssZZZ"];
	
	NSDate * _tmp_date = [formatter dateFromString:dateString];
	
	NSDate *_returnDate = nil;
	
	_returnDate = _tmp_date;
	
	return _returnDate;
}

//
// Convenience Method to quickly return a NSDate object from a date
// string with a specified date format
//
+(NSDate *)dateFromString:(NSString *)dateString withDateFormat:(NSString *)dateFormat
{
	[NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:dateFormat];
	
	NSDate *returnedDate = [formatter dateFromString:dateString];
	
	return returnedDate;
}

@end
