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

- (NSString *) cw_NSStringFromData {
    return [[NSString alloc] initWithData:self
								 encoding:NSUTF8StringEncoding];
}

- (const char *) cw_utf8StringFromData {
	return [[NSString stringWithUTF8String:[self bytes]] UTF8String];
}

-(NSString *)cw_hexString {
	NSUInteger capacity = [self length] * 2;
	NSMutableString *stringBuffer = [NSMutableString stringWithCapacity:capacity];
	const unsigned char *dataBuffer = [self bytes];
	
	for (NSUInteger i = 0; i < [self length]; ++i) {
		[stringBuffer appendFormat:@"%02X ",(unsigned int)dataBuffer[i]];
	}
	return (stringBuffer ? stringBuffer : nil);
}

@end
