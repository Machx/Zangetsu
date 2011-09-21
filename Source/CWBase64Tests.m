//
//  CWBase64Tests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 9/18/11.
//  Copyright 2011. All rights reserved.
//

#import "CWBase64Tests.h"
#import "CWBase64.h"

@implementation CWBase64Tests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

-(void)testBasicBase64Encoding {
    
    //clearly the right test string to test for base64 encoding
    NSString *testData =  @"All Hail the Hypnotoad!";
    
    NSString *resultString = [testData cw_base64EncodedString];
    NSString *goodResult = @"QWxsIEhhaWwgdGhlIEh5cG5vdG9hZCE=";
    
    STAssertTrue([resultString isEqualToString:goodResult], @"Strings should match");
}

-(void)testBasicBase64Decoding {
    NSString *testData = @"QWxsIEhhaWwgdGhlIEh5cG5vdG9hZCE=";
    
    NSString *resultString = [testData cw_base64DecodedString];
    NSString *goodResult =  @"All Hail the Hypnotoad!";
    
    STAssertTrue([resultString isEqualToString:goodResult], @"Base64 decoded string should equal the good result string");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
