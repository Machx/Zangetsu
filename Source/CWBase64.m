/*
//  CWBase64.m
//  Zangetsu
//
//  Created by Colin Wheeler on 9/18/11.
//  Copyright 2012. All rights reserved.
//
 
 */

#import "CWBase64.h"
#import <Security/Security.h>

#define CWBASE64CLEANUP() \
	CFShow(error); \
	CFRelease(data); \
	CFRelease(encoder);

@implementation NSString (CWBase64Encoding)

- (NSString *)cw_base64EncodedString
{
    SecTransformRef encoder;
    CFErrorRef error = NULL;
    const char *string = [self UTF8String];
    
    CFDataRef data = CFDataCreate(kCFAllocatorDefault, (const unsigned char *)string, strlen(string));
    if (data == NULL) { return nil; }
    
    encoder = SecEncodeTransformCreate(kSecBase64Encoding, &error);
    if (error) { CWBASE64CLEANUP(); return nil; }
    
    SecTransformSetAttribute(encoder, kSecTransformInputAttributeName, data, &error);
    if (error) { CWBASE64CLEANUP(); return nil; }
    
    CFDataRef encodedData = SecTransformExecute(encoder, &error);
    if (!encodedData && error) { CWBASE64CLEANUP(); return nil; }
    
    NSString *base64String = nil;
    base64String = [[NSString alloc] initWithData:(__bridge NSData *)encodedData encoding:NSUTF8StringEncoding];
	CFRelease(data);
	CFRelease(encoder);
	CFBridgingRelease(encodedData);
    
    return base64String;
}

#undef CWBASE64CLEANUP

#define CWBASE64CLEANUP() \
	CFShow(error); \
	CFRelease(data); \
	CFRelease(decoder);


- (NSString *)cw_base64DecodedString
{
    SecTransformRef decoder;
    CFErrorRef error = NULL;
    const char *string = [self UTF8String];
    
    CFDataRef data = CFDataCreate(kCFAllocatorDefault, (const unsigned char *)string, strlen(string));
    if (data == NULL) { return nil; }
    
    decoder = SecDecodeTransformCreate(kSecBase64Encoding, &error);
    if (error) { CWBASE64CLEANUP(); return nil; }
    
    SecTransformSetAttribute(decoder, kSecTransformInputAttributeName, data, &error);
    if (error) { CWBASE64CLEANUP(); return nil; }
    
    CFDataRef decodedData = SecTransformExecute(decoder, &error);
    if (error) { CWBASE64CLEANUP(); CFRelease(decodedData); return nil; }
    
    NSString *base64DecodedString = nil;
    base64DecodedString = [[NSString alloc] initWithData:(__bridge NSData *)decodedData encoding:NSUTF8StringEncoding];
	CFRelease(data);
	CFRelease(decoder);
	CFBridgingRelease(decodedData);
    
    return base64DecodedString;
}

#undef CWBASE64CLEANUP

@end
