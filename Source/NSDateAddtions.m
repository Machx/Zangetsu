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

-(NSDate *)cw_dateByAddingMinutes:(NSUInteger)minutes {
	return [self dateByAddingTimeInterval:(kCWSecondsIn1Minute * minutes)];
}

-(NSDate *)cw_dateByAddingHours:(NSUInteger)hours {
	return [self dateByAddingTimeInterval:(kCWSecondsIn1Hour * hours)];
}

-(NSDate *)cw_dateByAddingDays:(NSUInteger)days {
	return [self dateByAddingTimeInterval:(kCWSecondsIn1Day * days)];
}

@end
