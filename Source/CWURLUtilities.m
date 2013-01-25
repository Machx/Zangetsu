/*
//  URLUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 2/11/11.
//  Copyright 2012. All rights reserved.
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

#import "CWURLUtilities.h"

static NSString * const kCWURLUtiltyErrorDomain = @"com.Zangetsu.CWURLUtilities";

NSURL *CWURL(NSString * urlFormat,...) {
    NSCParameterAssert(urlFormat);
	
	va_list args;
    va_start(args, urlFormat);
	NSString *urlString = [[NSString alloc] initWithFormat:urlFormat arguments:args];
	va_end(args);
	
	NSURL *_urlValue = [NSURL URLWithString:urlString];
    return _urlValue;
}

NSString *CWURLAuthorizationHeaderString(NSString *login, NSString *password) {
	if (login == nil) {
		CWLogErrorInfo(kCWURLUtiltyErrorDomain, 404,
					   @"Required Login string was nil");
		return nil;
	}
	if (password == nil) {
		CWLogErrorInfo(kCWURLUtiltyErrorDomain, 405,
					   @"Required Password string was nil");
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
