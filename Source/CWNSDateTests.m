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

SpecBegin(CWNSDateTests)

describe(@"-cw_dateByAddingMinutes", ^{
	it(@"should create the correct date", ^{
		NSDate *now = [NSDate date];
		NSDate *minutesFromNow1 = [now cw_dateByAddingMinutes:3
												usingCalendar:nil];
		NSDateComponents *components = [[NSDateComponents alloc] init];
		components.minute = 3;
		NSDate *minutesFromNow2 = [[NSCalendar currentCalendar] dateByAddingComponents:components
																				toDate:now
																			   options:0];
		
		expect([minutesFromNow1 compare:minutesFromNow2] == NSOrderedSame).to.beTruthy();
	});
});

describe(@"-cw_dateByAddingHours", ^{
	it(@"should create the correct date", ^{
		NSDate *now = [NSDate date];
		NSDate *hourFromNow1 = [now cw_dateByAddingHours:2
										   usingCalendar:nil];
		NSDateComponents *components = [[NSDateComponents alloc] init];
		components.hour = 2;
		NSDate *hourFromNow2 = [[NSCalendar currentCalendar] dateByAddingComponents:components
																			 toDate:now
																			options:0];
		
		expect([hourFromNow1 compare:hourFromNow2] == NSOrderedSame).to.beTruthy();
	});
});

describe(@"-cw_dateByAddingDays", ^{
	it(@"should create the correct date", ^{
		NSDate *today = [NSDate date];
		NSDateComponents *components = [[NSDateComponents alloc] init];
		components.day = 1;
		NSDate *tomorrow = [[NSCalendar currentCalendar] dateByAddingComponents:components
																		 toDate:today
																		options:0];
		NSDate *tomorrow2 = [today cw_dateByAddingDays:1
										 usingCalendar:nil];
		
		expect([tomorrow compare:tomorrow2] == NSOrderedSame).to.beTruthy();
	});
});

SpecEnd
