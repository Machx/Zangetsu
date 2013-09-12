/*
//  CWBase64.m
//  Zangetsu
//
//  Created by Colin Wheeler on 9/18/11.
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

#import "CWBase64.h"
#import <Security/Security.h>

@implementation NSString (CWBase64Encoding)

- (NSString *)cw_base64EncodedString {
    SecTransformRef encoder;
    CFErrorRef error = NULL;
    const char *string = [self UTF8String];
    
    CFDataRef data = CFDataCreate(kCFAllocatorDefault, (const unsigned char *)string, strlen(string));
    if (data == NULL) return nil;
    
    encoder = SecEncodeTransformCreate(kSecBase64Encoding, &error);
    if (error) {
		CWBASE64CLEANUP();
		return nil;
	}
    
    SecTransformSetAttribute(encoder, kSecTransformInputAttributeName, data, &error);
    if (error) {
		CWBASE64CLEANUP();
		return nil;
	}
    
    CFDataRef encodedData = SecTransformExecute(encoder, &error);
    if (!encodedData && error) {
		CWBASE64CLEANUP();
		return nil;
	}
    
    NSString *base64String = nil;
    base64String = [[NSString alloc] initWithData:(__bridge NSData *)encodedData
										 encoding:NSUTF8StringEncoding];
	CFRelease(data);
	CFRelease(encoder);
	CFBridgingRelease(encodedData);
    
    return base64String;
}

- (NSString *)cw_base64DecodedString {
    SecTransformRef decoder;
    CFErrorRef error = NULL;
    const char *string = [self UTF8String];
    
    CFDataRef data = CFDataCreate(kCFAllocatorDefault, (const unsigned char *)string, strlen(string));
    if (data == NULL) return nil;
    
    decoder = SecDecodeTransformCreate(kSecBase64Encoding, &error);
    if (error) {
		CWBASE64CLEANUP();
		return nil;
	}
    
    SecTransformSetAttribute(decoder, kSecTransformInputAttributeName, data, &error);
    if (error) {
		CWBASE64CLEANUP();
		return nil;
	}
    
    CFDataRef decodedData = SecTransformExecute(decoder, &error);
    if (error) {
		CWBASE64CLEANUP();
		CFRelease(decodedData);
		return nil;
	}
    
    NSString *base64DecodedString = nil;
    base64DecodedString = [[NSString alloc] initWithData:(__bridge NSData *)decodedData
												encoding:NSUTF8StringEncoding];
	CFRelease(data);
	CFRelease(decoder);
	CFBridgingRelease(decodedData);
    
    return base64DecodedString;
}

@end
