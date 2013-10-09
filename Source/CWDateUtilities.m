/*
//  CWDateUtilities.m
//
//  Created by Colin Wheeler on 10/16/10.
//  Copyright 2010. All rights reserved.

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

#import "CWDateUtilities.h"

#pragma mark General Date Functions -

NSString * CWDateString(NSDate * date) {
	if(date == nil) return nil;
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss Z";
	formatter.timeZone = [[NSCalendar currentCalendar] timeZone];
	
	return [formatter stringFromDate:date];
}

NSDate * CWDateFromComponents(NSInteger year, NSInteger month, NSInteger day,
                              NSInteger hour, NSInteger minute, NSInteger second,
							  NSTimeZone *timeZone, NSCalendar *calendar) {
    NSDateComponents * components = [[NSDateComponents alloc] init];
    components.timeZone = (timeZone ? timeZone : [NSTimeZone systemTimeZone]);
	components.year = year;
	components.month = month;
	components.day = day;
	components.hour = hour;
	components.minute = minute;
	components.second = second;
	
	NSCalendar *aCalendar = (calendar ? calendar : [NSCalendar currentCalendar]);
	if (calendar) {
		NSDate * date = [aCalendar dateFromComponents:components];
		return date;
	}
    return nil;
}

NSDate *CWDateFromISO8601String(NSString *dateString)  {
	NSCParameterAssert(dateString != nil);
	NSDate *isoDate = CWDateFromString(dateString, kCWISO8601TimeFormat);
	return (isoDate ?: CWDateFromString(dateString, kCWISO8601TimeFormat2));
}

NSDate *CWDateFromString(NSString * dateString, NSString *dateFormat) {
    [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
	formatter.dateFormat = dateFormat;

    return [formatter dateFromString:dateString];
}

#pragma mark NSDateExtensions -

@implementation NSDate (CWNSDateAddtions)

#pragma mark Component Methods -

-(NSDateComponents *)cw_dateComponents {
	NSUInteger units = NSYearCalendarUnit  | NSMonthCalendarUnit |
	                     NSDayCalendarUnit | NSHourCalendarUnit  |
				      NSMinuteCalendarUnit | NSSecondCalendarUnit;
	return [self cw_dateComponentsWithUnits:units];
}

-(NSDateComponents *)cw_dateComponentsWithUnits:(NSUInteger)calendarUnits {
	return [self cw_dateComponentsWithUnits:calendarUnits
							  usingCalendar:[NSCalendar currentCalendar]];
}

-(NSDateComponents *)cw_dateComponentsWithUnits:(NSUInteger)calendarUnits
								  usingCalendar:(NSCalendar *)calendar {
	NSCalendar *cal = (calendar ?: [NSCalendar currentCalendar]);
	return [cal components:calendarUnits fromDate:self];
}

#pragma mark Date by Adding Methods

-(NSDate *)cw_dateByAddingMinutes:(NSInteger)minutes
					usingCalendar:(NSCalendar *)dateCal {
	NSDateComponents *components = [[NSDateComponents alloc] init];
	components.minute = minutes;
	NSCalendar *calendar = (dateCal ?: [NSCalendar currentCalendar]);
	return [calendar dateByAddingComponents:components
									 toDate:self
									options:0];
}

-(NSDate *)cw_dateByAddingHours:(NSInteger)hours
				  usingCalendar:(NSCalendar *)dateCal {
	NSDateComponents *components = [[NSDateComponents alloc] init];
	components.hour = hours;
	NSCalendar *calendar = (dateCal ?: [NSCalendar currentCalendar]);
	return [calendar dateByAddingComponents:components
									 toDate:self
									options:0];
}

-(NSDate *)cw_dateByAddingDays:(NSInteger)days
				 usingCalendar:(NSCalendar *)dateCal {
	NSDateComponents *components = [[NSDateComponents alloc] init];
	components.day = days;
	NSCalendar *calendar = (dateCal ?: [NSCalendar currentCalendar]);
	return [calendar dateByAddingComponents:components
									 toDate:self
									options:0];
}

@end
