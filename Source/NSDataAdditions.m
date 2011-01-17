//
//  NSDataAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 1/15/11.
//  Copyright 2011. All rights reserved.
//

#import "NSDataAdditions.h"


@implementation NSData (CWNSDataAdditions)

-(NSString *)cw_NSStringFromData
{
	NSString *_result = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
	
	return _result;
}

-(const char *)cw_utf8StringFromData
{
	NSString *_result = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];

	const char *cRep = [_result UTF8String];

	return cRep;
}

@end
