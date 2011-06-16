//
//  CWDateUtilitiesTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 6/16/11.
//  Copyright 2011. All rights reserved.
//

#import "CWDateUtilitiesTests.h"
#import "CWDateUtilities.h"

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

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
