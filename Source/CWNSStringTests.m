/*
//  CWNSStringTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/5/10.
//  Copyright 2010. All rights reserved.
//
 	*/

#import "CWNSStringTests.h"
#import <Zangetsu/Zangetsu.h>
#import "CWAssertionMacros.h"

@implementation CWNSStringTests

-(void)testUUIDStrings
{
	NSString *string1 = [NSString cw_uuidString];
	NSString *string2 = [NSString cw_uuidString];
	
	CWAssertNotEqualsObjects(string1, string2, @"Both Strings should be unique");
}

-(void)testEmptyStringMethod
{
	//test data that should be empty
	NSString *emptyString1 = @"";
	STAssertFalse([emptyString1 cw_isNotEmptyString],@"String1 should be empty");
	
	//test data that should not return empty
	NSString *testString2 = @"Fry";
	STAssertTrue([testString2 cw_isNotEmptyString],@"TestString should not be empty");
}

-(void)testURLEscaping
{	
	NSString *urlCharsString = @"@!*'()[];:&=+$,/?%#";
	
	NSString *escapedString = [urlCharsString cw_escapeEntitiesForURL];
	
	NSCharacterSet *testIllegalCharSet = [NSCharacterSet characterSetWithCharactersInString:@"@!*'()[];:&=+$,/?#"];
	
	NSInteger location = [escapedString rangeOfCharacterFromSet:testIllegalCharSet].location;
	
	STAssertTrue(location == NSNotFound, @"chars in set shouldn't be found");
}

-(void)testURLEscapingPercentString
{
	NSString *testCharString = @"%";
	NSString *escapedString = [testCharString cw_escapeEntitiesForURL];
	
	CWAssertEqualsStrings(escapedString, @"%25");
}

-(void)testEnumerateSubStrings
{    
    NSString *string  = @"This\nis\na\nstring\nwith\nmany\nlines.";
    
    __block int32_t count = 0;
    
    [string cw_enumerateConcurrentlyWithOptions:NSStringEnumerationByLines usingBlock:^(NSString *substring) {
        OSAtomicIncrement32(&count);
    }];
    
    STAssertTrue(count == 7, @"Count should be 7");
}

@end
