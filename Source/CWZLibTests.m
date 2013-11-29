/*
//  CWZLibTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 9/25/11.
//  Copyright 2012. All rights reserved.
//
 
 Copyright (c) 2013, Colin Wheeler
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 - Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "CWZLib.h"

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
