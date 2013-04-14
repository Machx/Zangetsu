/*
//  CWDateUtilities.m
//
//  Created by Colin Wheeler on 10/16/10.
//  Copyright 2010. All rights reserved.

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

#import "CWDateUtilities.h"

#pragma mark General Date Functions -

NSString * CWDateString(NSDate * date) {
	if (date) {
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss Z";
		formatter.timeZone = [[NSCalendar currentCalendar] timeZone];
		
		return [formatter stringFromDate:date];
	}
	return nil;
}

NSDate * CWDateFromComponents(NSInteger year, NSInteger month, NSInteger day,
                              NSInteger hour, NSInteger minute, NSInteger second,
							  NSTimeZone *timeZone, NSCalendar *calendar) {
    NSDateComponents * components = [[NSDateComponents alloc] init];
    if (components) {
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
            if (date) return date;
        }
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

-(NSDate *)cw_dateByAddingMinutes:(NSInteger)minutes
					usingCalendar:(NSCalendar *)dateCal {
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setMinute:minutes];
	NSCalendar *calendar = (dateCal ?: [NSCalendar currentCalendar]);
	return [calendar dateByAddingComponents:components
									 toDate:self
									options:0];
}

-(NSDate *)cw_dateByAddingHours:(NSInteger)hours
				  usingCalendar:(NSCalendar *)dateCal {
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setHour:hours];
	NSCalendar *calendar = (dateCal ?: [NSCalendar currentCalendar]);
	return [calendar dateByAddingComponents:components
									 toDate:self
									options:0];
}

-(NSDate *)cw_dateByAddingDays:(NSInteger)days
				 usingCalendar:(NSCalendar *)dateCal {
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setDay:days];
	NSCalendar *calendar = (dateCal ?: [NSCalendar currentCalendar]);
	return [calendar dateByAddingComponents:components
									 toDate:self
									options:0];
}

@end
