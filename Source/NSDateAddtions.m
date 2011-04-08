//
//  NSDateAddtions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 3/31/11.
//  Copyright 2011. All rights reserved.
//

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
