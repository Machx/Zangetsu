/*
//  CWNSDateTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 4/2/11.
//  Copyright 2012. All rights reserved.
//
 	*/

#import "CWNSDateTests.h"
#import "NSDateAddtions.h"

@implementation CWNSDateTests

-(void)testDateByAddingMinutes
{	
	NSDate *now = [NSDate date];
	
	NSDate *minutesFromNow1 = [now cw_dateByAddingMinutes:3 usingCalendar:nil];
	
	NSDateComponents *components = [[NSDateComponents alloc] init];
	components.minute = 3;
	NSDate *minutesFromNow2 = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:now options:0];
	
	STAssertTrue([minutesFromNow1 compare:minutesFromNow2] == NSOrderedSame, @"Dates should be the same");
}

-(void)testDateByAddingHours 
{	
	NSDate *now = [NSDate date];
	
	NSDate *hourFromNow1 = [now cw_dateByAddingHours:2 usingCalendar:nil];
	
	NSDateComponents *components = [[NSDateComponents alloc] init];
	components.hour = 2;
	NSDate *hourFromNow2 = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:now options:0];
	
	STAssertTrue([hourFromNow1 compare:hourFromNow2] == NSOrderedSame, @"Dates should be the same");
}

-(void)testDateByAddingDays 
{
	NSDate *today = [NSDate date];
	
	NSDateComponents *components = [[NSDateComponents alloc] init];
	components.day = 1;
	NSDate *tomorrow = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:today options:0];
	
	NSDate *tomorrow2 = [today cw_dateByAddingDays:1 usingCalendar:nil];
	
	STAssertTrue([tomorrow compare:tomorrow2] == NSOrderedSame, @"Dates should be the same");
}

@end
