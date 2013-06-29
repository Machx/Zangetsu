/*
//  CWErrorUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/23/10.
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
	CWAssert(errorMessageFormat != nil);
	
    NSString * _domain = (domain ?: kCWErrorDomain);
	
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

BOOL CWErrorTrap(BOOL cond,
				NSError *(^errorBlock)(void),
				NSError **error) {
	if(!cond) return NO;
	if(error) *error = errorBlock();
	return YES;
}
