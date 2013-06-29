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

#define CWZLIBCLEANUP() \
	CFShow(error); \
	CFRelease(inputData); \
	CFRelease(encoder);

@implementation NSData (CWZLib)

-(NSData *)cw_zLibCompress {
    SecTransformRef encoder;
	CFDataRef data = NULL;
    CFErrorRef error = NULL;
    
    CFDataRef inputData = CFDataCreate(kCFAllocatorDefault, [self bytes], [self length]);
    if (inputData == NULL) return nil;
    encoder = SecEncodeTransformCreate(kSecZLibEncoding, &error);
    if(error) {
		CWZLIBCLEANUP();
		return nil;
	}
    SecTransformSetAttribute(encoder, kSecTransformInputAttributeName, inputData, &error);
    if (error) {
		CWZLIBCLEANUP();
		return nil;
	}
	data = SecTransformExecute(encoder, &error);
    if (error) {
		CWZLIBCLEANUP();
		CFRelease(data);
		return nil;
	}
    
	CFRelease(encoder);
	CFRelease(inputData);
	
    return (__bridge_transfer NSData *)data; 
}

#undef CWZLIBCLEANUP

#define CWZLIBCLEANUP() \
	CFShow(error); \
	CFRelease(inputData); \
	CFRelease(decoder);

-(NSData *)cw_zLibDecompress {
    SecTransformRef decoder = NULL;
	CFDataRef decodedData = NULL;
    CFErrorRef error = NULL;
    
    CFDataRef inputData = CFDataCreate(kCFAllocatorDefault, [self bytes], [self length]);
    if (inputData == NULL) return nil;
    decoder = SecDecodeTransformCreate(kSecZLibEncoding, &error);
    if (error) {
		CWZLIBCLEANUP();
		return nil;
	}
    SecTransformSetAttribute(decoder, kSecTransformInputAttributeName, inputData, &error);
    if (error) {
		CWZLIBCLEANUP();
		return nil;
	}
    decodedData = SecTransformExecute(decoder, &error);
    if (error) {
		CWZLIBCLEANUP();
		CFRelease(decodedData);
		return nil;
	}
    
	CFRelease(inputData);
	CFRelease(decoder);
    
    return (__bridge_transfer NSData *)decodedData;
}

#undef CWZLIBCLEANUP

@end
