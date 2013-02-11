//
//  CWZLibTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 9/25/11.
//  Copyright 2012. All rights reserved.
//

#import "CWZLibTests.h"
#import "CWZLib.h"
#import "CWAssertionMacros.h"

SpecBegin(CWZLib)

describe(@"-cw_zLibCompress + -cw_zLibDecompress", ^{
	it(@"should be able to compress & decompress an object & get the same result", ^{
		const NSString *testString = @"We need some globetrotter physics!";
		const char *testStringU = [testString UTF8String];
		NSData *data = [NSData dataWithBytes:testStringU length:strlen(testStringU)];
		
		NSData *compressedData = [data cw_zLibCompress];
		
		expect(data).notTo.equal(compressedData);
		
		NSData *decompressedData = [compressedData cw_zLibDecompress];
		NSString *finalResultString = [[NSString alloc] initWithData:decompressedData
															encoding:NSUTF8StringEncoding];
		
		expect(finalResultString).to.equal(testString);
	});
});

SpecEnd
