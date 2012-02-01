/*
//  CWSHA1_Convenience.m
//  Zangetsu
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


#import "CWSHA1Utilities.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (CWSHA1Utilities)

/**
 * Return the SHA1 value of the string passed in
 * @param str a NSString of which you want to get its SHA1 hash from
 * @return a NSString containing the SHA1 hash (in lowercase form)
 */
+ (NSString *) cw_sha1HashFromString:(NSString *)str {
    NSParameterAssert(str);

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

/**
 * Convience method to return the SHA1 value of the contents of a NSData object given
 *
 * @return a NSString object with the SHA1 hash of the NSData objects contents
 */
- (NSString *) cw_sha1StringFromData {
    NSString * str = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
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
