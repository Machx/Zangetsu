/*
//  CWZLib.m
//  Zangetsu
//
//  Created by Colin Wheeler on 9/25/11.
//  Copyright 2012. All rights reserved.
//
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
    if (inputData == NULL) { return nil; }
    
    encoder = SecEncodeTransformCreate(kSecZLibEncoding, &error);
    if(error) { CWZLIBCLEANUP(); return nil; }
    
    SecTransformSetAttribute(encoder, kSecTransformInputAttributeName, inputData, &error);
    if (error) { CWZLIBCLEANUP(); return nil; }
    
	data = SecTransformExecute(encoder, &error);
    if (error) { CWZLIBCLEANUP(); CFRelease(data); return nil; }
    
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
    if (inputData == NULL) { return nil; }
    
    decoder = SecDecodeTransformCreate(kSecZLibEncoding, &error);
    if (error) { CWZLIBCLEANUP(); return nil; }
    
    SecTransformSetAttribute(decoder, kSecTransformInputAttributeName, inputData, &error);
    if (error) { CWZLIBCLEANUP(); return nil; }
    
    decodedData = SecTransformExecute(decoder, &error);
    if (error) { CWZLIBCLEANUP(); CFRelease(decodedData); return nil; }
    
	CFRelease(inputData);
	CFRelease(decoder);
    
    return (__bridge_transfer NSData *)decodedData;
}

#undef CWZLIBCLEANUP

@end
