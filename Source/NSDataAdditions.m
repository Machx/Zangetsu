/*
//  NSDataAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 1/15/11.
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

#import "NSDataAdditions.h"

@implementation NSData (CWNSDataAdditions)

/**
 Returns a NSString from the contents of the data encoded in UTF8 encoding
 
 @return a NSString from the contents of the NSData object, if the data object is nil this returns nil
 */
- (NSString *) cw_NSStringFromData {
	if (self == nil || [self length] == 0) { return nil; }
    NSString * _result = [[NSString alloc] initWithData:self 
											   encoding:NSUTF8StringEncoding];
    return _result;
}

/**
 Returns a const char from the contents of the NSData object encoded in UTF8 encoding
 
 @return a const char * from the contents of the NSData object, if the data object is nil this returns nil
 */
- (const char *) cw_utf8StringFromData {
	if (self == nil || [self length] == 0) { return NULL; }
    NSString * _result = [[NSString alloc] initWithData:self 
											   encoding:NSUTF8StringEncoding];
    const char * cRep = [_result UTF8String];
    return cRep;
}

/**
 returns a string with the representation of the data in hex
 
 @return a NSString with the data representation in hex or nil if the data is nil or its length is 0
 */
-(NSString *)cw_hexString {
	if (self == nil || [self length] == 0) { return nil; }
	
	NSUInteger capacity = [self length] * 2;
	NSMutableString *stringBuffer = [NSMutableString stringWithCapacity:capacity];
	const unsigned char *dataBuffer = [self bytes];
	
	for (NSUInteger i = 0; i < [self length]; ++i) {
		[stringBuffer appendFormat:@"%02X ",(NSUInteger)dataBuffer[i]];
	}
	if (stringBuffer) {
		return stringBuffer;
	}
	return nil;
}

@end
