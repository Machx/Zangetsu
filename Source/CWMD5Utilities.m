/*
//  CWMD5Utilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/29/10.
//  Copyright 2010. All rights reserved.
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

#import "CWMD5Utilities.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (CWMD5Utilities)

+(NSString *)cw_md5HashFromString:(NSString *)string {
	CWAssert(string != nil);
	const char *cStringRep = [string UTF8String];
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

-(NSString *)cw_md5StringFromData {
	NSString *str = [[NSString alloc] initWithData:self
										  encoding:NSUTF8StringEncoding];
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
