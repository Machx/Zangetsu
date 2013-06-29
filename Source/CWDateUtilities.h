/*
//  CWDateUtilities.h
//
//  Created by Colin Wheeler on 10/16/10.
//  Copyright 2010. All rights reserved.
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

#import <Foundation/Foundation.h>

static NSString * const kCWISO8601TimeFormat = @"yyyy/MM/dd HH:mm:ss ZZZ";
static NSString * const kCWISO8601TimeFormat2 = @"yyyy-MM-dd'T'HH:mm:ss'Z'";;

#pragma mark General Date Functions -

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
NSDate *CWDateFromISO8601String(NSString *dateString);

/**
 Convert a NSString object containing a date to a NSDate object with date format
 
 Convenience Method to quickly return a NSDate object from a date
 string with a specified date format
 
 @param dateString A NSString Object which the date is to be extracted from
 @param dateFormat The Format the dateString object is in
 @return a NSDate object with the date if successful or nil if unsuccessful
 */
NSDate *CWDateFromString(NSString * dateString, NSString *dateFormat);

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

#pragma mark NSDateExtensions -

@interface NSDate (CWNSDateAddtions)

/**
 Returns a new date object with the same date as the original but n minutes ahead
 
 @param minutes the number of minutes you want the new date object to advance by
 @param dateCal a NSCalendar object you want to be used for the date calculation
 or nil if you want [NSCalendar currentCalendar]
 @return a new NSDate object advanced forward by n minutes
 */
-(NSDate *)cw_dateByAddingMinutes:(NSInteger)minutes usingCalendar:(NSCalendar *)dateCal;

/**
 Returns a new date object with the same date as the original but n hours ahead
 
 @param hours the number of hours you want the new date object to advance by
 @param dateCal a NSCalendar object you want to be used for the date calculation
 or nil if you want [NSCalendar currentCalendar]
 @return a new NSDate object advanced forward by n hours
 */
-(NSDate *)cw_dateByAddingHours:(NSInteger)hours usingCalendar:(NSCalendar *)dateCal;

/**
 Returns a new date object with the same date as the original but n days ahead
 
 @param days number of days you want the new date object to advance by
 @param dateCal a NSCalendar object you want to be used for the date calculation
 or nil if you want [NSCalendar currentCalendar]
 @return a new NSDate object advanced forward by n days
 */
-(NSDate *)cw_dateByAddingDays:(NSInteger)days usingCalendar:(NSCalendar *)dateCal;

@end
