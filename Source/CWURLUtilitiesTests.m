//
//  CWURLUtilitiesTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/3/11.
//  Copyright (c) 2012. All rights reserved.
//

#import "CWURLUtilitiesTests.h"
#import <Zangetsu/Zangetsu.h>
#import "CWAssertionMacros.h"

@implementation CWURLUtilitiesTests

-(void)testBasicBase64AuthHeader
{
	NSString *authorizationHeaderString = CWURLAuthorizationHeaderString(@"TestAccount", @"TestPassword");
	NSString *const goodResultString = @"Basic VGVzdEFjY291bnQ6VGVzdFBhc3N3b3Jk";
	
	CWAssertEqualsStrings(authorizationHeaderString, goodResultString);
}

-(void)testBase64AuthHeaderWithNilData
{
	STAssertNil(CWURLAuthorizationHeaderString(nil, @"TestPassword"), @"Returned String should be nil");
	STAssertNil(CWURLAuthorizationHeaderString(@"Test Account", nil), @"Returned String should be nil");
}

@end
