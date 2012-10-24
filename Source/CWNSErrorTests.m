/*
//  CWNSErrorTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 3/14/11.
//  Copyright 2012. All rights reserved.
//
 
 */

#import "CWNSErrorTests.h"
#import "CWErrorUtilities.h"
#import "CWMacros.h"
#import "CWAssertionMacros.h"

@implementation CWNSErrorTests

/**
 Testing CWCreateError()
 tests to make sure that the values passed in to each NSError object is the same regardless 
 if a NSError is created with NSError -errorWithDomain:code:... or CWCreateError()
 */
-(void)testCreateError
{	
	NSError *error1 = CWCreateError(@"com.something.something",101, @"Some Message");
	
	NSError *error2 = [NSError errorWithDomain:@"com.something.something" code:101 userInfo:@{ NSLocalizedDescriptionKey : @"Some Message" }];
	
	STAssertTrue([error1 code] == [error2 code], @"Error 1 and 2 codes should be the same");
	CWAssertEqualsStrings(error1.domain, error2.domain);
	
	NSString *error1Message = [[error1 userInfo] valueForKey:NSLocalizedDescriptionKey];
	NSString *error2Message = [[error2 userInfo] valueForKey:NSLocalizedDescriptionKey];
	
	CWAssertEqualsStrings(error1Message, error2Message);
    
    //testing the string format on this NSError method
    NSError *error3 = CWCreateError(@"com.something.something", 101, @"Some %@",@"Message");
    
    NSString *error3Message = [[error3 userInfo] valueForKey:NSLocalizedDescriptionKey];
    
	CWAssertEqualsStrings(error2Message, error3Message);
}

@end
