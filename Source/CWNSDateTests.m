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

SpecBegin(CWDateUtilities)

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

describe(@"-dateFromString:withFormat:", ^{
	it(@"should create a valid date with the correct values", ^{
		NSDate *date1 = CWDateFromString(@"2012-07-01 11:05:00", @"yyyy-M-dd h:mm:ss");
		NSDate *date2 = CWDateFromComponents(2012, 07, 01, 11, 05, 00, nil, [NSCalendar currentCalendar]);
		
		expect(date1).to.equal(date2);
	});
});

describe(@"CWDateFromComponents()", ^{
	it(@"should return a valid NSDate instance with correct values", ^{
		NSDate *date1 = CWDateFromComponents(2012, 06, 06, 10, 0, 0, nil, [NSCalendar currentCalendar]);
		
		NSCalendar *calendar = [NSCalendar currentCalendar];
		NSDateComponents *components = [[NSDateComponents alloc] init];
		components.year = 2012;
		components.month = 06;
		components.day = 06;
		components.hour = 10;
		components.minute = 0;
		components.second = 0;
		components.timeZone = [calendar timeZone];
		
		NSDate *date2 = [calendar dateFromComponents:components];
		
		expect(date1).to.equal(date2);
	});
	
	it(@"should return different date instances when different timezones are passed in", ^{
		NSDate *date1 = CWDateFromComponents(2012, 10, 14, 02, 30, 0, nil, [NSCalendar currentCalendar]);
		NSDate *date2 = CWDateFromComponents(2012, 10, 14, 02, 30, 0, [NSTimeZone timeZoneForSecondsFromGMT:0], [NSCalendar currentCalendar]);
		
		expect(date1).notTo.equal(date2);
	});
});

describe(@"-dateFromISO8601String", ^{
	it(@"should correctly parse ISO 8601 Date Strings", ^{
		NSString *data = @"1994-11-05T13:15:30Z";
		NSDate *date1 = CWDateFromISO8601String(data);
		
		expect(date1).notTo.beNil();
		
		NSDate *date2 = CWDateFromComponents(1994, 11, 05, 13, 15, 30, nil, [NSCalendar currentCalendar]);
		
		expect(date1).to.equal(date2);
	});
});

SpecEnd
