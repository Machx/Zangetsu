/*
//  CWDateUtilities.h
//
//  Created by Colin Wheeler on 10/16/10.
//  Copyright 2010. All rights reserved.
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

#import <Foundation/Foundation.h>

static NSString * const kCWISO8601TimeFormat = @"yyyy/MM/dd HH:mm:ss ZZZ";
static NSString * const kCWISO8601TimeFormat2 = @"yyyy-MM-dd'T'HH:mm:ss'Z'";;

@interface CWDateUtilities : NSObject

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
+(NSDate *)dateFromISO8601String:(NSString *)dateString;

/**
 Convert a NSString object containing a date to a NSDate object with date format
 
 Convenience Method to quickly return a NSDate object from a date
 string with a specified date format
 
 @param dateString A NSString Object which the date is to be extracted from
 @param dateFormat The Format the dateString object is in
 @return a NSDate object with the date if successful or nil if unsuccessful
 */
+(NSDate *)dateFromString:(NSString *)dateString withDateFormat:(NSString *)dateFormat;

@end

/**
 Returns a NSString with a description of the NSDate object
 
 Currently this method uses the "%Y-%m-%d %H:%M:%S %z" format to
 describe the passed in NSDate object. If date is nil then this returns nil.
 
 @param date a NSDate object
 @return a NSString with describing the NSDate object
 */
NSString *CWDateString(NSDate *date);

/**
 Creates a NSDate object from the values passed in for date components
 
 Internally this gets a NSDate from the users current calendar
 
 @param year a NSInteger for the year of the date desired
 @param month a NSInteger for the month of the date desired
 @param day a NSInteger for the day of the date desired
 @param hour a NSInteger for the hour of the date desired
 @param minute a NSInteger for the minute of the date desired
 @param second a NSInteger for the second of the date desired
 @param timeZone a valid NSTimeZone object or nil for the system timezone
 @return a NSDate object if successful, nil otherwise
 */
NSDate * CWDateFromComponents(NSInteger year, NSInteger month, NSInteger day,
                              NSInteger hour, NSInteger minute, NSInteger second,
							  NSTimeZone *timeZone, NSCalendar *calendar);
