//
//  CWBase64Tests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 9/18/11.
//  Copyright 2012. All rights reserved.
//

#import "CWBase64Tests.h"
#import "CWBase64.h"
#import "CWAssertionMacros.h"

SpecBegin(CWBase64)

describe(@"-cw_base64EncodedString", ^{
	it(@"should properly encode a given string", ^{
		//clearly the right test string to test for base64 encoding
		NSString *testData =  @"All Hail the Hypnotoad!";
		
		NSString *resultString = [testData cw_base64EncodedString];
		NSString *goodResult = @"QWxsIEhhaWwgdGhlIEh5cG5vdG9hZCE=";
		
		expect(resultString).to.equal(goodResult);
	});
});

describe(@"-cw_base64DecodedString", ^{
	it(@"should correctly decode a given string", ^{
		//clearly the right test string to test for base64 encoding
		NSString *testData =  @"All Hail the Hypnotoad!";
		NSString *resultString = [testData cw_base64EncodedString];
		NSString *goodResult = @"QWxsIEhhaWwgdGhlIEh5cG5vdG9hZCE=";
		
		expect(resultString).to.equal(goodResult);
	});
});

SpecEnd
