/*
//  CWErrorUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/23/10.
//  Copyright 2010. All rights reserved.
//
 
 Copyright (c) 2012 Colin Wheeler
 
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

#import "CWErrorUtilities.h"

NSError * CWCreateError(NSString * domain,
						NSInteger errorCode,
						NSString * errorMessageFormat, ...) {
    va_list args;
    va_start(args, errorMessageFormat);
    NSString * fullErrorMessage = [[NSString alloc] initWithFormat:errorMessageFormat
														 arguments:args];
    va_end(args);

	return CWCreateErrorWithUserInfo(domain, errorCode, nil, fullErrorMessage);
}

NSError * CWCreateErrorWithUserInfo(NSString * domain,
									NSInteger errorCode,
									NSDictionary *info,
									NSString * errorMessageFormat, ...) {
    NSCParameterAssert(errorMessageFormat);
    NSCParameterAssert(errorCode);
	
    NSString * _domain = (domain ? domain : kCWErrorDomain);
	
    va_list args;
    va_start(args, errorMessageFormat);
    NSString * completeErrorMessage = [[NSString alloc] initWithFormat:errorMessageFormat
															 arguments:args];
    va_end(args);
	
	NSMutableDictionary *_errorDictionary = [NSMutableDictionary new];
	[_errorDictionary addEntriesFromDictionary:@{ NSLocalizedDescriptionKey : completeErrorMessage }];
	if (info) [_errorDictionary addEntriesFromDictionary:info];
	
    return [NSError errorWithDomain:_domain
                               code:errorCode
                           userInfo:_errorDictionary];
}

void CWLogErrorInfo(NSString * domain,
					NSInteger errorCode,
					NSString * errorMessageFormat, ...) {
	va_list args;
    va_start(args, errorMessageFormat);
    NSString * fullErrorMessage = [[NSString alloc] initWithFormat:errorMessageFormat
														 arguments:args];
    va_end(args);
	
	NSError *error = CWCreateError(domain, errorCode, fullErrorMessage);
	CWLogError(error);
}

void CWErrorSet(NSString *domain,
				NSInteger errorCode,
				NSString *errorMessageFormat,
				NSError **error) {
	CWErrorSetV(domain, errorCode, errorMessageFormat, nil, error);
}

void CWErrorSetV(NSString *domain,
				 NSInteger errorCode,
				 NSString *errorMessageFormat,
				 NSDictionary *userInfo,
				 NSError **error) {
	if (error) *error = CWCreateErrorWithUserInfo(domain, errorCode, userInfo, errorMessageFormat);
}

BOOL CWErrorTrap(BOOL cond,
				NSError *(^errorBlock)(void),
				NSError **error) {
	if (cond) {
		if(error) *error = errorBlock();
		return YES;
	}
	return NO;
}
