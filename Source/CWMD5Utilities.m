//
//  CWMD5Utilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/29/10.
//  Copyright 2010. All rights reserved.
//

#import "CWMD5Utilities.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (CWMD5Utilities)

/**
 Return the MD5 value of the string passed in
 */
+(NSString *)cw_md5HashFromString:(NSString *)str 
{
	if(str == nil){
		return nil;
	}
	
	const char *cStringRep = [str UTF8String];
	unsigned char md5Hash[CC_MD5_DIGEST_LENGTH];
	
	CC_MD5(cStringRep, (CC_LONG)strlen(cStringRep), md5Hash);
	
	NSString *shaHashString = [NSString  stringWithFormat:
							   @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
							   md5Hash[0], md5Hash[1], md5Hash[2], md5Hash[3], 
							   md5Hash[4], md5Hash[5], md5Hash[6], md5Hash[7], 
							   md5Hash[8], md5Hash[9], md5Hash[10], md5Hash[11], 
							   md5Hash[12], md5Hash[13], md5Hash[14], md5Hash[15]];
	
	return [shaHashString lowercaseString];
}

@end

@implementation NSData (CWMD5Utilities)

/**
 Convience method to return the MD5 value of the contents of a NSData object given
 */
-(NSString *)cw_md5StringFromData
{
	NSString *str = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
	const char *cStringRep = [str UTF8String];
	unsigned char md5Hash[CC_MD5_DIGEST_LENGTH];
	
	CC_MD5(cStringRep, (CC_LONG)strlen(cStringRep), md5Hash);
	
	NSString *shaHashString = [NSString  stringWithFormat:
							   @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
							   md5Hash[0], md5Hash[1], md5Hash[2], md5Hash[3], 
							   md5Hash[4], md5Hash[5], md5Hash[6], md5Hash[7], 
							   md5Hash[8], md5Hash[9], md5Hash[10], md5Hash[11], 
							   md5Hash[12], md5Hash[13], md5Hash[14], md5Hash[15]];
	
	return [shaHashString lowercaseString];
}

@end