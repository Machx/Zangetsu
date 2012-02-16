/*
//  CWMD5Utilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/29/10.
//  Copyright 2010. All rights reserved.
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

#import "CWMD5Utilities.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (CWMD5Utilities)

/**
 Return the MD5 value of the string passed in
 */
+(NSString *)cw_md5HashFromString:(NSString *)str {
	const char *cStringRep = [str UTF8String];
	unsigned char md5Hash[CC_MD5_DIGEST_LENGTH];
	
	CC_MD5(cStringRep, (CC_LONG)strlen(cStringRep), md5Hash);
	NSString *md5HashString = [NSString  stringWithFormat:
							   @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
							   md5Hash[0], md5Hash[1], md5Hash[2], md5Hash[3], md5Hash[4],
							   md5Hash[5], md5Hash[6], md5Hash[7], md5Hash[8], md5Hash[9],
							   md5Hash[10], md5Hash[11], md5Hash[12], md5Hash[13], md5Hash[14],
							   md5Hash[15]];
	
	return [md5HashString lowercaseString];
}

@end

@implementation NSData (CWMD5Utilities)

/**
 Convience method to return the MD5 value of the contents of a NSData object given
 */
-(NSString *)cw_md5StringFromData {
	NSString *str = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
	const char *cStringRep = [str UTF8String];
	unsigned char md5Hash[CC_MD5_DIGEST_LENGTH];
	
	CC_MD5(cStringRep, (CC_LONG)strlen(cStringRep), md5Hash);
	NSString *md5HashString = [NSString  stringWithFormat:
							   @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
							   md5Hash[0], md5Hash[1], md5Hash[2], md5Hash[3], md5Hash[4],
							   md5Hash[5], md5Hash[6], md5Hash[7], md5Hash[8], md5Hash[9],
							   md5Hash[10], md5Hash[11], md5Hash[12], md5Hash[13], md5Hash[14],
							   md5Hash[15]];
	
	return [md5HashString lowercaseString];
}

@end
