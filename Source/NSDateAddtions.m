/*
//  NSDateAddtions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 3/31/11.
//  Copyright 2012. All rights reserved.
//
 
 */

#import "NSDateAddtions.h"

@implementation NSDate (CWNSDateAddtions)

-(NSDate *)cw_dateByAddingMinutes:(NSInteger)minutes usingCalendar:(NSCalendar *)dateCal
{
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setMinute:minutes];
	NSCalendar *calendar = (dateCal) ? dateCal : [NSCalendar currentCalendar];
	NSDate *date = [calendar dateByAddingComponents:components toDate:self options:0];	
	return date;
}

-(NSDate *)cw_dateByAddingHours:(NSInteger)hours usingCalendar:(NSCalendar *)dateCal
{
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setHour:hours];
	NSCalendar *calendar = (dateCal) ? dateCal : [NSCalendar currentCalendar];
	NSDate *date = [calendar dateByAddingComponents:components toDate:self options:0];
	return date;
}

-(NSDate *)cw_dateByAddingDays:(NSInteger)days usingCalendar:(NSCalendar *)dateCal {
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setDay:days];
	NSCalendar *calendar = (dateCal) ? dateCal : [NSCalendar currentCalendar];
	NSDate *date = [calendar dateByAddingComponents:components toDate:self options:0];
	return date;
}

@end
