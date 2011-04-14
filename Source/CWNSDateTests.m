//
//  CWNSDateTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 4/2/11.
//  Copyright 2011. All rights reserved.
//

#import "CWNSDateTests.h"
#import "NSDateAddtions.h"

@implementation CWNSDateTests

-(void)testDateByAddingMinutes {
	
	NSDate *now = [NSDate date];
	
	NSDate *minutesFromNow1 = [now cw_dateByAddingMinutes:3];
	NSDate *minutesFromNow2 = [now dateByAddingTimeInterval:180];
	
	STAssertTrue([minutesFromNow1 compare:minutesFromNow2] == NSOrderedSame, @"Dates should be the same");
}

-(void)testDateByAddingHours {
	
	NSDate *now = [NSDate date];
	
	NSDate *hourFromNow1 = [now cw_dateByAddingHours:2];
	NSDate *hourFromNow2 = [now dateByAddingTimeInterval:7200];
	
	STAssertTrue([hourFromNow1 compare:hourFromNow2] == NSOrderedSame, @"Dates should be the same");
}

-(void)testDateByAddingDays {
	
	NSDate *today = [NSDate date];
	
	NSDate *tomorrow = [today dateByAddingTimeInterval:86400];
	NSDate *tomorrow2 = [today cw_dateByAddingDays:1];
	
	STAssertTrue([tomorrow compare:tomorrow2] == NSOrderedSame, @"Dates should be the same");
}

@end
