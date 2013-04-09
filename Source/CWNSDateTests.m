/*
//  CWNSDateTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 4/2/11.
//  Copyright 2012. All rights reserved.
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

#import "CWNSDateTests.h"
#import "CWDateUtilities.h"

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
