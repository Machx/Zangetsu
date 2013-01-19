/*
//  CWFoundationTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 6/25/11.
//  Copyright 2012. All rights reserved.
//
 	*/

#import "CWFoundationTests.h"
#import "CWFoundation.h"
#import "CWMacros.h"
#import "CWAssertionMacros.h"

@implementation CWFoundationTests

- (void)setUp {
    [super setUp];
    
    // Set-up code here.
}

-(void)testClassExists
{
    STAssertTrue(CWClassExists(@"NSString"), @"NSString should exist");
    STAssertFalse(CWClassExists(@"Hypnotoad"), @"Hypnotoad class shouldn't exist");
}

-(void)testBoolString
{
    //just test the 2 bool values...
    
    NSString *yesString = CWBOOLString(YES);
	CWAssertEqualsStrings(yesString, @"YES");
    
    NSString *noString = CWBOOLString(NO);
	CWAssertEqualsStrings(noString, @"NO");
	
	NSString *str = @"Yes";
	NSString *str2 = CWBOOLString([str boolValue]);
	CWAssertEqualsStrings(str2, @"YES");
	
	NSString *str3 = nil;
	NSString *str4 = CWBOOLString([str3 boolValue]);
	CWAssertEqualsStrings(str4, @"NO");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
