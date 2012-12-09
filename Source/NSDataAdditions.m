/*
//  NSDataAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 1/15/11.
//  Copyright 2012. All rights reserved.
//
 	*/

#import "NSDataAdditions.h"

@implementation NSData (CWNSDataAdditions)

- (NSString *) cw_NSStringFromData
{
    NSString * _result = [[NSString alloc] initWithData:self 
											   encoding:NSUTF8StringEncoding];
    return _result;
}

- (const char *) cw_utf8StringFromData
{
    NSString * _result = [[NSString alloc] initWithData:self 
											   encoding:NSUTF8StringEncoding];
    const char * cRep = [_result UTF8String];
    return cRep;
}

-(NSString *)cw_hexString
{
	NSUInteger capacity = [self length] * 2;
	NSMutableString *stringBuffer = [NSMutableString stringWithCapacity:capacity];
	const unsigned char *dataBuffer = [self bytes];
	
	for (NSUInteger i = 0; i < [self length]; ++i) {
		[stringBuffer appendFormat:@"%02X ",(unsigned int)dataBuffer[i]];
	}
	if (stringBuffer) {
		return stringBuffer;
	}
	return nil;
}

@end
