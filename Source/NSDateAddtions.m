/*
//  NSDateAddtions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 3/31/11.
//  Copyright 2011. All rights reserved.
//
 
 Copyright (c) 2011 Colin Wheeler
 
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

#import "NSDateAddtions.h"

static const NSTimeInterval kCWSecondsIn1Minute = 60;
static const NSTimeInterval kCWSecondsIn1Hour = 3600;
static const NSTimeInterval kCWSecondsIn1Day = 86400;

@implementation NSDate (CWNSDateAddtions)

/**
 Returns a new date object with the same date as the original but n minutes ahead
 
 @param minutes a NSInteger with the number of minutes you want the new date object to advance by
 @return a new NSDate object advanced forward by n minutes
 */
-(NSDate *)cw_dateByAddingMinutes:(NSUInteger)minutes {
	return [self dateByAddingTimeInterval:(kCWSecondsIn1Minute * minutes)];
}

/**
 Returns a new date object with the same date as the original but n hours ahead
 
 @param hours a NSInteger with the number of hours you want the new date object to advance by
 @return a new NSDate object advanced forward by n hours
 */
-(NSDate *)cw_dateByAddingHours:(NSUInteger)hours {
	return [self dateByAddingTimeInterval:(kCWSecondsIn1Hour * hours)];
}

/**
 Returns a new date object with the same date as the original but n days ahead
 
 @param days a NSInteger with the number of days you want the new date object to advance by
 @return a new NSDate object advanced forward by n days
 */
-(NSDate *)cw_dateByAddingDays:(NSUInteger)days {
	return [self dateByAddingTimeInterval:(kCWSecondsIn1Day * days)];
}

@end
