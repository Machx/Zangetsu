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

/**
 tests the CWDateString function which should output the description of the date
 */
-(void)testDateString {
	NSDate *now = [NSDate date];
	
	STAssertTrue([[now description] isEqualToString:CWDateString(now)],@"descriptions should be the same");
}

/**
 tests the CWDateStringFromComponents function to make sure we are getting an
 appropriate description back
 */
-(void)testDateStringFromComponents {
	//TOFIX: apparently in Lion the hour changes for some odd reason, need to fix this
	NSString *dateString = CWDateStringFromComponents(2011, 6, 9, 5, 0, 0);
	//we are testing the date string not the time zone...
	NSString *trimmedDateString = [dateString substringWithRange:NSMakeRange(0, 10)];
	
	//NSString *dateString2 = @"2011-06-09";
	
	NSLog(@"DateString: %@ - TrimString: %@",dateString,trimmedDateString);
	
	//STAssertTrue([trimmedDateString isEqualToString:dateString2],@"strings should be equal");
}

-(void)testDateFromStringWithFormat {	
	
	NSDate *date1 = [CWDateUtilities dateFromString:@"2011-07-01 11:05:00" withDateFormat:@"yyyy-M-dd h:mm:ss"];
	if (date1) {
		NSLog(@"Date1 is %@",date1);
	}
	
	NSDate *date2 = CWDateFromComponents(2011, 07, 01, 11, 05, 00);
	if (date2) {
		NSLog(@"Date2 is %@",date2);
	}
	
	//STAssertTrue([date1 isEqualToDate:date2], @"dates should be equal");
}

-(void)testDateFromComponents {
	
	NSDate *date1 = CWDateFromComponents(2011, 06, 06, 10, 0, 0);
	
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
	
	NSLog(@"Date1: %@\nDate2: %@",date1,date2);
	
	//STAssertTrue([date1 isEqualToDate:date2], @"dates should be equal");
}

-(void)test8601DateFormat1 {
	
	NSString *data = @"1994-11-05T13:15:30Z";
	
	NSDate *date1 = [CWDateUtilities dateFromISO8601String:data];
	
	NSLog(@"iso8601 date is %@",date1);
	
	STAssertNotNil(date1, @"should have a valid NSDate object");
	
	//TODO: test that the date is correct, which it doesn't appear to be right now...
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
