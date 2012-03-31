//
//  CWBase64Tests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 9/18/11.
//  Copyright 2011. All rights reserved.
//

#import "CWBase64Tests.h"
#import "CWBase64.h"
#import "CWAssertionMacros.h"

@implementation CWBase64Tests

- (void)setUp {
    [super setUp];
    
    // Set-up code here.
}

-(void)testBasicBase64Encoding {
	/**
	 making sure that the original test string properly encodes to
	 the good result that is expected. the good result can be verified
	 through any base 64 encoding testers online
	 */
    
    //clearly the right test string to test for base64 encoding
    NSString *testData =  @"All Hail the Hypnotoad!";
    
    NSString *resultString = [testData cw_base64EncodedString];
    NSString *goodResult = @"QWxsIEhhaWwgdGhlIEh5cG5vdG9hZCE=";
    
	CWAssertEqualsStrings(resultString, goodResult);
}

-(void)testBasicBase64Decoding {
	/**
	 decode the result we should have gotten in the last test
	 with the original string and make sure that our base64 
	 decoding works properly...
	 */
	
    NSString *testData = @"QWxsIEhhaWwgdGhlIEh5cG5vdG9hZCE=";
    
    NSString *resultString = [testData cw_base64DecodedString];
    NSString *goodResult =  @"All Hail the Hypnotoad!";
    
	CWAssertEqualsStrings(resultString, goodResult);
}

- (void)tearDown {
    // Tear-down code here.
    
    [super tearDown];
}

@end
