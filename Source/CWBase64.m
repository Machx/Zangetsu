/*
//  CWBase64.m
//  Zangetsu
//
//  Created by Colin Wheeler on 9/18/11.
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

#import "CWBase64.h"
#import <Security/Security.h>

@implementation NSString (CWBase64Encoding)

- (NSString *)cw_base64EncodedString
{
    SecTransformRef encoder;
    CFErrorRef error = NULL;
    
    const char* string = [self UTF8String];
    
    CFDataRef data = CFDataCreate(kCFAllocatorDefault, (const unsigned char *)string, strlen(string));
    
    encoder = SecEncodeTransformCreate(kSecBase64Encoding, &error);
    
    SecTransformSetAttribute(encoder, kSecTransformInputAttributeName, data, &error);
    
    CFDataRef encodedData = SecTransformExecute(encoder, &error);
    
    NSString *base64String = nil;
    base64String = [[NSString alloc] initWithData:(NSData *)encodedData encoding:NSUTF8StringEncoding];
    
    return base64String;
}

@end
