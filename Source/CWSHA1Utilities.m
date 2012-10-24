/*
//  CWSHA1_Convenience.m
//  Zangetsu
//
 
 */


#import "CWSHA1Utilities.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (CWSHA1Utilities)


+ (NSString *) cw_sha1HashFromString:(NSString *)str
{
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

- (NSString *) cw_sha1StringFromData
{
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
