/*
//  CWZLib.m
//  Zangetsu
//
//  Created by Colin Wheeler on 9/25/11.
//  Copyright 2011. All rights reserved.
//
 
 Copyright (c) 2011 Colin Wheeler
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
 
#import "CWZLib.h"
#import <Security/Security.h>

@implementation NSData (CWZLib)

-(NSData *)cw_zLibCompress {
    SecTransformRef encoder;
    CFErrorRef error = NULL;
    
    CFDataRef inputData = CFDataCreate(kCFAllocatorDefault, [self bytes], [self length]);
    if (inputData == NULL) {
        return nil;
    }
    
    encoder = SecEncodeTransformCreate(kSecZLibEncoding, &error);
    if(error) { 
        CFShow(error);
		CFRelease(inputData);
		CFRelease(encoder);
        return nil; 
    }
    
    SecTransformSetAttribute(encoder, kSecTransformInputAttributeName, inputData, &error);
    if (error) {
        CFShow(error);
		CFRelease(inputData);
		CFRelease(encoder);
        return nil;
    }
    
    CFDataRef data = NULL;
	data = SecTransformExecute(encoder, &error);
    if (error) {
        CFShow(error);
		CFRelease(inputData);
		CFRelease(encoder);
        return nil;
    }
    
	CFRelease(encoder);
	CFRelease(inputData);
    NSData *compressedData = nil;
    compressedData = [[NSData alloc] initWithData:(__bridge NSData *)data];
	
    return compressedData; 
}

-(NSData *)cw_zLibDecompress {
    SecTransformRef decoder = NULL;
    CFErrorRef error = NULL;
    
    CFDataRef inputData = CFDataCreate(kCFAllocatorDefault, [self bytes], [self length]);
    if (inputData == NULL) {
        return nil;
    }
    
    decoder = SecDecodeTransformCreate(kSecZLibEncoding, &error);
    if (error) {
        CFShow(error);
		CFRelease(inputData);
		CFRelease(decoder);
        return nil;
    }
    
    SecTransformSetAttribute(decoder, kSecTransformInputAttributeName, inputData, &error);
    if (error) {
        CFShow(error);
		CFRelease(inputData);
		CFRelease(decoder);
        return nil;
    }
    
    CFDataRef decodedData = NULL;
    decodedData = SecTransformExecute(decoder, &error);
    if (error) {
        CFShow(error);
		CFRelease(inputData);
		CFRelease(decoder);
        return nil;
    }
    
    NSData *nsDecodedData = [[NSData alloc] initWithData:(__bridge NSData *)decodedData];
	CFRelease(inputData);
	CFRelease(decoder);
    
    return nsDecodedData;
}

@end
