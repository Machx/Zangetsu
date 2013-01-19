/*
//  CWErrorUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/23/10.
//  Copyright 2010. All rights reserved.
//
 	*/

#import "CWErrorUtilities.h"

NSError * CWCreateError(NSString * domain, NSInteger errorCode,
						NSString * errorMessageFormat, ...)
{
    va_list args;
    va_start(args, errorMessageFormat);
    NSString * fullErrorMessage = [[NSString alloc] initWithFormat:errorMessageFormat
														 arguments:args];
    va_end(args);

	return CWCreateErrorWithUserInfo(domain, errorCode, nil, fullErrorMessage);
}

NSError * CWCreateErrorWithUserInfo(NSString * domain, NSInteger errorCode,
									NSDictionary *info,
									NSString * errorMessageFormat, ...)
{
    NSCParameterAssert(errorMessageFormat);
    NSCParameterAssert(errorCode);
	
    NSString * _domain = (domain) ? domain : kCWErrorDomain;
	
    va_list args;
    va_start(args, errorMessageFormat);
    NSString * completeErrorMessage = [[NSString alloc] initWithFormat:errorMessageFormat
															 arguments:args];
    va_end(args);
	
	NSMutableDictionary *_errorDictionary = [NSMutableDictionary new];
	[_errorDictionary addEntriesFromDictionary:@{ NSLocalizedDescriptionKey : completeErrorMessage }];
	if (info) {
		[_errorDictionary addEntriesFromDictionary:info];
	}
	
    return [NSError errorWithDomain:_domain
                               code:errorCode
                           userInfo:_errorDictionary];
}

void CWLogErrorInfo(NSString * domain, NSInteger errorCode,
					NSString * errorMessageFormat, ...)
{
	va_list args;
    va_start(args, errorMessageFormat);
    NSString * fullErrorMessage = [[NSString alloc] initWithFormat:errorMessageFormat
														 arguments:args];
    va_end(args);
	
	NSError *error = CWCreateError(domain, errorCode, fullErrorMessage);
	CWLogError(error);
}
