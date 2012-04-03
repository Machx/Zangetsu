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

-(void)testBasicCompression
{
    /**
     This test works in the simplest way possible. What is does is create a reference
     NSString object, then put it inside a NSData object, compress it using zlib encoding
     through the zangetsu zlib api then decompress it through the zangetsu zlib decompress api
     and compare the strings. If everything went well we should end up with the exact same
     NSString value we started with.
     
     Note if you accidentally try to decompress a NSData that wasn't compressed with zlib you
     apparently get back error -3 from zlib the compression/decompression methods will return nil
     */
    
    const NSString *testString = @"We need some globetrotter physics!";
    
    const char *testStringU = [testString UTF8String];
    
    NSData *data = [NSData dataWithBytes:testStringU length:strlen(testStringU)];
    
    NSData *compressedData = [data cw_zLibCompress];
    
    //make sure we don't have the exact same NSData contents we started out with
    STAssertFalse([compressedData isEqualToData:data],@"Data contents should not be the smae");
    
    NSData *decompressedData = [compressedData cw_zLibDecompress];
    
    NSString *finalResultString = [[NSString alloc] initWithData:decompressedData 
                                                        encoding:NSUTF8StringEncoding];
    
    STAssertTrue([testString isEqualToString:finalResultString],@"Strings should be the same");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
