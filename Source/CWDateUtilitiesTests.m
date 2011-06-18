//
//  CWDateUtilitiesTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 6/16/11.
//  Copyright 2011. All rights reserved.
//

#import "CWDateUtilitiesTests.h"
#import "CWDateUtilities.h"

//TODO: test the "1994-11-05T08:15:30-05:00" format for ISO8601...

@implementation CWDateUtilitiesTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

-(void)testDateString {
	NSDate *now = [NSDate date];
	
	STAssertTrue([[now description] isEqualToString:CWDateString(now)],@"descriptions should be the same");
}

-(void)testDateStringFromComponents {
	
	NSString *dateString = CWDateStringFromComponents(2011, 6, 9, 5, 0, 0);
	//we are testing the date string not the time zone...
	NSString *trimmedDateString = [dateString substringWithRange:NSMakeRange(0, 19)];
	
	NSString *dateString2 = @"2011-06-09 05:00:00";
	
	STAssertTrue([trimmedDateString isEqualToString:dateString2],@"strings should be equal");
}

-(void)testDateFromComponents {
	
	NSDate *date1 = CWDateFromComponents(2011, 06, 06, 10, 0, 0);
	
	NSDateComponents *components = [[NSDateComponents alloc] init];
	
	[components setYear:2011];
	[components setMonth:06];
	[components setDay:06];
	[components setHour:10];
	[components setMinute:0];
	[components setSecond:0];
	
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
	NSDate *date2 = [calendar dateFromComponents:components];
	
	STAssertTrue([date1 isEqualToDate:date2], @"dates should be equal");
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
