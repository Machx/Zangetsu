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

-(void)testDateByAddingDays {
	
	NSDate *today = [NSDate date];
	
	NSDate *tomorrow = [today dateByAddingTimeInterval:86400];
	NSDate *tomorrow2 = [today cw_dateByAddingDays:1];
	
	STAssertTrue([tomorrow compare:tomorrow2] == NSOrderedSame, @"Dates should be the same");
}

@end
