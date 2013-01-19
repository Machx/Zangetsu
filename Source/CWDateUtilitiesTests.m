/*
//  CWDateUtilitiesTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 6/16/11.
//  Copyright 2012. All rights reserved.
//
 	*/

#import "CWDateUtilitiesTests.h"
#import "CWDateUtilities.h"
#import "CWAssertionMacros.h"

@implementation CWDateUtilitiesTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

-(void)testDateStringFromComponents
{
	/**
	 tests the CWDateStringFromComponents function to make sure we are getting an
	 appropriate description back
	 */
	NSString *dateString = CWDateStringFromComponents(2012, 6, 9, 14, 0, 0, nil, [NSCalendar currentCalendar]);
	NSLog(@"Date 1: %@", dateString);
	NSString *dateString2 = @"2012-06-09 14:00:00 -0400";
	NSLog(@"Date 2: %@", dateString2);
	CWAssertEqualsStrings(dateString, dateString2);
}

-(void)testDateFromStringWithFormat
{	
	/**
	 make sure that the -dateFromString:withDateFormat: api returns the correct date
	 from the passed in string it is given
	 */
	NSDate *date1 = [CWDateUtilities dateFromString:@"2012-07-01 11:05:00" withDateFormat:@"yyyy-M-dd h:mm:ss"];
	
	NSDate *date2 = CWDateFromComponents(2012, 07, 01, 11, 05, 00, nil, [NSCalendar currentCalendar]);
	
	STAssertTrue([date1 isEqualToDate:date2], @"dates should be equal");
}

-(void)testDateFromComponents
{
	/**
	 make sure that the CWDateFromComponents() api works as it should
	 in giving a correct date from the components passed into it.
	 */
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
	
	STAssertTrue([date1 isEqualToDate:date2], @"dates should be equal");
}

-(void)testTimeZoneDateFromComponents
{
	/**
	 testing passing in the timezone to make sure that the returned NSDate
	 objects are different when different timezones are passed in
	 */
	
	/**
	 this date should grab the current timezone that the host system
	 is setup with and currently using
	 */
	NSDate *date1 = CWDateFromComponents(2012, 10, 14, 02, 30, 0, nil, nil);
	
	/**
	 when the timezone is non nil then the method should grab the passed
	 in timezone and use that for the date.
	 */
	NSDate *date2 = CWDateFromComponents(2012, 10, 14, 02, 30, 0, [NSTimeZone timeZoneForSecondsFromGMT:0], nil);
	
	STAssertFalse([date1 isEqualToDate:date2], @"Dates should not be the same");
}

-(void)test8601DateFormat1
{
	/**
	 test that we are getting a date from the -dateFromISO8601String API
	 and that the value is correct.
	 */
	NSString *data = @"1994-11-05T13:15:30Z";
	
	NSDate *date1 = [CWDateUtilities dateFromISO8601String:data];
	
	STAssertNotNil(date1, @"should have a valid NSDate object");
	
	NSDate *date2 = CWDateFromComponents(1994, 11, 05, 13, 15, 30, nil, [NSCalendar currentCalendar]);
	
	STAssertTrue([date1 isEqualToDate:date2], @"Dates should be equal");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
