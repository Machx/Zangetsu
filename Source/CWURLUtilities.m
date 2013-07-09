/*
//  URLUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 2/11/11.
//  Copyright 2012. All rights reserved.
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

#import "CWURLUtilities.h"

static NSString * const kCWURLUtiltyErrorDomain = @"com.Zangetsu.CWURLUtilities";

NSURL *CWURL(NSString * urlFormat,...) {
	CWAssert(urlFormat != nil);
	
	va_list args;
    va_start(args, urlFormat);
	NSString *urlString = [[NSString alloc] initWithFormat:urlFormat arguments:args];
	va_end(args);
	
	NSURL *_urlValue = [NSURL URLWithString:urlString];
    return _urlValue;
}

NSString *CWURLAuthorizationHeaderString(NSString *login, NSString *password) {
	if (login == nil) {
		CWLogInfo(@"Required Login was nil... returning nil");
		return nil;
	}
	if (password == nil) {
		CWLogInfo(@"Required Password was nil... returning nil");
		return nil;
	}
	
	NSString *tempBasicAuthString = [NSString stringWithFormat:@"%@:%@",login,password];
	NSString *encodedAuth = nil;
	encodedAuth = [tempBasicAuthString  cw_base64EncodedString];
	if (encodedAuth) {
		NSString *authString = [[NSString alloc] initWithFormat:@"Basic %@",encodedAuth];
		return authString;
	}
	return nil;
}

@implementation CWURLUtilities

+ (NSError *)errorWithLocalizedMessageForStatusCode:(NSInteger)code {
    NSString * localizedMessage = [NSHTTPURLResponse localizedStringForStatusCode:code];
    if (localizedMessage) {
        return CWCreateError(kCWURLUtiltyErrorDomain, code, localizedMessage);
    }
    return nil;
}

@end
