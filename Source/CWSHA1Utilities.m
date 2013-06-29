/*
//  CWSHA1_Convenience.m
//  Zangetsu
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


#import "CWSHA1Utilities.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (CWSHA1Utilities)

+ (NSString *) cw_sha1HashFromString:(NSString *)str {
    CWAssert(str != nil);

    const char * cStringRep = [str UTF8String];
    unsigned char shaHash[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(cStringRep, (CC_LONG)strlen(cStringRep), shaHash);

    NSString * shaHashString = [NSString stringWithFormat:
                                @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                                shaHash[0], shaHash[1], shaHash[2], shaHash[3], shaHash[4],
                                shaHash[5], shaHash[6], shaHash[7], shaHash[8], shaHash[9],
                                shaHash[10], shaHash[11], shaHash[12], shaHash[13], shaHash[14],
                                shaHash[15], shaHash[16], shaHash[17], shaHash[18], shaHash[19]];

    return [shaHashString lowercaseString];
}

@end

@implementation NSData (CWSHA1Utilities)

- (NSString *) cw_sha1StringFromData {
    NSString * str = [[NSString alloc] initWithData:self
										   encoding:NSUTF8StringEncoding];
    const char * cStringRep = [str UTF8String];
    unsigned char shaHash[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(cStringRep, (CC_LONG)strlen(cStringRep), shaHash);

    NSString * shaHashString = [NSString stringWithFormat:
                                @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                                shaHash[0], shaHash[1], shaHash[2], shaHash[3], shaHash[4],
                                shaHash[5], shaHash[6], shaHash[7], shaHash[8], shaHash[9],
                                shaHash[10], shaHash[11], shaHash[12], shaHash[13], shaHash[14],
                                shaHash[15], shaHash[16], shaHash[17], shaHash[18], shaHash[19]];

    return [shaHashString lowercaseString];
}

@end
