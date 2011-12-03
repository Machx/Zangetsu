//
//  CWURLUtilitiesTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/3/11.
//  Copyright (c) 2011. All rights reserved.
//

#import "CWURLUtilitiesTests.h"
#import <Zangetsu/Zangetsu.h>

@implementation CWURLUtilitiesTests

-(void)testBasicBase64AuthHeader {
	NSString *authorizationHeaderString = CWURLAuthorizationHeaderString(@"TestAccount", @"TestPassword");
	NSString *const goodResultString = @"Basic VGVzdEFjY291bnQ6VGVzdFBhc3N3b3Jk";
	STAssertTrue([authorizationHeaderString isEqualToString:goodResultString], @"Strings Should match given the input");
}

@end
