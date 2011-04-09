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
 Converts a NSString with a ISO8601 Date Format to a NSDate object
 
 Experimental method for parsing ISO8601 Strings given usually when 
 XML data is given back. This method now tries to use a standard format
 for trying to extract a date from the string. If the 1st ISO8601 format
 does not work then it will try to use a 2nd variation before finally
 giving up all together. In the short term this will work, however in the
 long run I'll need to design something to parse a date string and return
 a date based on the information given.
 
 @param dateString The String containing a ISO8601 Date
 @return A NSDate Object if successful or nil if not successful
 */
+(NSDate *)dateFromISO8601String:(NSString *)dateString
{
	NSDate *isoDate = nil;
	
	isoDate = [self dateFromString:dateString 
					withDateFormat:kCWISO8601TimeFormat];
	
	if(isoDate == nil)
		isoDate = [self dateFromString:dateString 
						withDateFormat:kCWISO8601TimeFormat2];
	
	return isoDate;
}

/**
 Converts a NSString object containing a date to a NSDate object given a date format
 
 Convenience Method to quickly return a NSDate object from a date
 string with a specified date format
 
 @param dateString A NSString Object which the date is to be extracted from
 @param dateFormat The Format the dateString object is in
 @return a NSDate object with the date if successful or nil if unsuccessful
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

/**
 Returns a NSString in NSDates description format
 
 @param date a NSDate object
 @return a NSString with NSDates description format
 */
NSString *CWDateString(NSDate *date) {
	return [date description];
}

/**
 Returns a NSString using NSDates description format
 
 @param year a NSInteger with the year value
 @param month a NSInteger with the month value
 @param day a NSInteger with the day value
 @param hour a NSInteger with the hour value
 @param minute a NSInteger with the minute value
 @param second a NSInteger with the second value
 */
NSString *CWDateStringFromComponents(NSInteger year,NSInteger month, NSInteger day,
									 NSInteger hour,NSInteger minute, NSInteger second) {
	NSDateComponents *components = [[NSDateComponents alloc] init];
	
	if(components){
		[components setYear:year];
		[components setMonth:month];
		[components setDay:day];
		[components setMinute:minute];
		[components setSecond:second];
		
		NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		
		if(calendar){
			NSDate *date = [calendar dateFromComponents:components];
			
			if(date){
				return [date description];
			}
		}
	}
	
	return nil;
}
