/*
//  CWZLib.m
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
#import <Security/Security.h>

@implementation NSData (CWZLib)

-(NSData *)cw_zLibCompress {
    __block SecTransformRef encoder;
	__block CFDataRef data = NULL;
    __block CFErrorRef error = NULL;
    
    __block CFDataRef inputData = CFDataCreate(kCFAllocatorDefault,
											   [self bytes],
											   [self length]);
    if (inputData == NULL) return nil;
	
	//returning nil allows us to cleanup & return all in 1 statement
	id (^zlibCompressCleanup)(void) = ^id{
		CFShow(error);
		CFRelease(inputData);
		if(encoder) CFRelease(encoder);
		if(data) CFRelease(data);
		return nil;
	};
	
    encoder = SecEncodeTransformCreate(kSecZLibEncoding, &error);
    if(error) return zlibCompressCleanup();
	
    SecTransformSetAttribute(encoder, kSecTransformInputAttributeName, inputData, &error);
    if (error) return zlibCompressCleanup();
	
	data = SecTransformExecute(encoder, &error);
    if (error) return zlibCompressCleanup();
    
	CFRelease(encoder);
	CFRelease(inputData);
	
    return (__bridge_transfer NSData *)data; 
}

-(NSData *)cw_zLibDecompress {
    __block SecTransformRef decoder = NULL;
	__block CFDataRef decodedData = NULL;
    __block CFErrorRef error = NULL;
    
    __block CFDataRef inputData = CFDataCreate(kCFAllocatorDefault,
											   [self bytes],
											   [self length]);
    if (inputData == NULL) return nil;
	
	//returning nil allows us to cleanup & return all in 1 statement
	id (^zlibDecompressCleanup)(void) = ^id{
		CFShow(error);
		CFRelease(inputData);
		if (decoder) CFRelease(decoder);
		if (decodedData) CFRelease(decodedData);
		return nil;
	};
	
    decoder = SecDecodeTransformCreate(kSecZLibEncoding, &error);
    if (error) return zlibDecompressCleanup();
	
    SecTransformSetAttribute(decoder, kSecTransformInputAttributeName, inputData, &error);
    if (error) return zlibDecompressCleanup();
	
    decodedData = SecTransformExecute(decoder, &error);
    if (error) return zlibDecompressCleanup();
    
	CFRelease(inputData);
	CFRelease(decoder);
    
    return (__bridge_transfer NSData *)decodedData;
}

@end
