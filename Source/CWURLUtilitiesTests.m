//
//  CWURLUtilitiesTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/3/11.
//  Copyright (c) 2012. All rights reserved.
//

#import "CWURLUtilitiesTests.h"
#import <Zangetsu/Zangetsu.h>

SpecBegin(CWURLUtilities)

describe(@"CWURLAuthorizationHeaderString()", ^{
	it(@"should create an expected result from a given input", ^{
		NSString *authorizationHeaderString = CWURLAuthorizationHeaderString(@"TestAccount", @"TestPassword");
		NSString *const goodResultString = @"Basic VGVzdEFjY291bnQ6VGVzdFBhc3N3b3Jk";
		
		expect(authorizationHeaderString).to.equal(goodResultString);
	});
	
	it(@"should return nil when either username or password is nil", ^{
		expect(CWURLAuthorizationHeaderString(nil, @"TestPassword")).to.beNil();
		expect(CWURLAuthorizationHeaderString(@"Test Account", nil)).to.beNil();
	});
});

SpecEnd
