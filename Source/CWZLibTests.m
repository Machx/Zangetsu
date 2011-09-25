//
//  CWZLibTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 9/25/11.
//  Copyright 2011. All rights reserved.
//

#import "CWZLibTests.h"
#import "CWZLib.h"

@implementation CWZLibTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

-(void)testBasicCompression {
    
    const NSString *testString = @"We need some globetrotter physics!";
    
    const char *testStringU = [testString UTF8String];
    
    NSData *data = [NSData dataWithBytes:testStringU length:strlen(testStringU)];
    
    NSData *compressedData = [data cw_zLibCompress];
    
    STAssertFalse([compressedData isEqualToData:data],@"Data contents should not be the smae");
    
    NSData *decompressedData = [compressedData cw_zLibDecompress];
    
    NSString *finalResultString = [[NSString alloc] initWithData:decompressedData encoding:NSUTF8StringEncoding];
    
    STAssertTrue([testString isEqualToString:finalResultString],@"Strings should be the same");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
