/*
//  CWDateUtilitiesTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 6/16/11.
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

#import "CWDateUtilitiesTests.h"
#import "CWDateUtilities.h"

//TODO: test the "1994-11-05T08:15:30-05:00" format for ISO8601...

@implementation CWDateUtilitiesTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

-(void)testDateStringFromComponents {
	/**
	 tests the CWDateStringFromComponents function to make sure we are getting an
	 appropriate description back
	 */
	NSString *dateString = CWDateStringFromComponents(2011, 6, 9, 14, 0, 0, nil);
	
	NSString *dateString2 = @"2011-06-09 14:00:00 -0500";
	
	STAssertTrue([dateString isEqualToString:dateString2],@"strings should be equal");
}

-(void)testDateFromStringWithFormat {	
	/**
	 make sure that the -dateFromString:withDateFormat: api returns the correct date
	 from the passed in string it is given
	 */
	NSDate *date1 = [CWDateUtilities dateFromString:@"2011-07-01 11:05:00" withDateFormat:@"yyyy-M-dd h:mm:ss"];
	
	NSDate *date2 = CWDateFromComponents(2011, 07, 01, 11, 05, 00, nil);
	
	STAssertTrue([date1 isEqualToDate:date2], @"dates should be equal");
}

-(void)testDateFromComponents {
	/**
	 make sure that the CWDateFromComponents() api works as it should
	 in giving a correct date from the components passed into it.
	 */
	NSDate *date1 = CWDateFromComponents(2011, 06, 06, 10, 0, 0, nil);
	
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [[NSDateComponents alloc] init];
	
	[components setYear:2011];
	[components setMonth:06];
	[components setDay:06];
	[components setHour:10];
	[components setMinute:0];
	[components setSecond:0];
	[components setTimeZone:[calendar timeZone]];
	
	NSDate *date2 = [calendar dateFromComponents:components];
	
	STAssertTrue([date1 isEqualToDate:date2], @"dates should be equal");
}

-(void)test8601DateFormat1 {
	/**
	 test that we are getting a date from the -dateFromISO8601String API
	 and that the value is correct.
	 */
	NSString *data = @"1994-11-05T13:15:30Z";
	
	NSDate *date1 = [CWDateUtilities dateFromISO8601String:data];
	
	STAssertNotNil(date1, @"should have a valid NSDate object");
	
	NSDate *date2 = CWDateFromComponents(1994, 11, 05, 13, 15, 30, nil);
	
	STAssertTrue([date1 isEqualToDate:date2], @"Dates should be equal");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
