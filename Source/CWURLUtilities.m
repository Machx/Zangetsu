/*
//  URLUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 2/11/11.
//  Copyright 2011. All rights reserved.
//
 
 Copyright (c) 2011 Colin Wheeler
 
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

/**
 * Creates a NSURL with the string passed in
 *
 * Creates a URL with the string passed in to create a NSURL object
 *
 * @param url a NSString containing a url address with any additional formatting options you want to create a NSURL object from
 * @return a NSURL object from the string passed in
 */
NSURL *CWURL(NSString * urlFormat,...) {
    NSCParameterAssert(urlFormat);
	
	va_list args;
    va_start(args, urlFormat);
	
	NSString *urlString = [[NSString alloc] initWithFormat:urlFormat arguments:args];
	
	va_end(args);
	
	NSURL *_urlValue = [NSURL URLWithString:urlString];

    return _urlValue;
}

/**
 Creates a authorization header string like "Basic {base64encodedlogin}"
 
 where "{base64encodedlogin}" is your login and password encoded via base64
 encoding. If either the passed in login or password are nil the function
 will throw an assertion.
 
 @param login a NSString with your login identity
 @param password a NSString with the password corresponding to the login identity
 @return a NSString with a value that can be set as the authorization header value or nil if there was a problem
 */
NSString *CWURLAuthorizationHeaderString(NSString *login, NSString *password) {
	NSCParameterAssert(login);
	NSCParameterAssert(password);
	
	NSString *tempBasicAuthString = [NSString stringWithFormat:@"%@:%@",login,password];
	NSString *encodedAuth = nil;
	encodedAuth = [tempBasicAuthString  cw_base64EncodedString];
	if (encodedAuth) {
		NSString *authString = [[NSString alloc] initWithFormat:@"Basic %@",encodedAuth];
		return authString;
	}
	return nil;
}

static NSString * const kCWURLUtiltyErrorDomain = @"com.Zangetsu.CWURLUtilities";

@implementation CWURLUtilities

+ (NSError *) errorWithLocalizedMessageForStatusCode:(NSInteger)code {
    NSString * localizedMessage = [NSHTTPURLResponse localizedStringForStatusCode:code];

    if (localizedMessage) {
        return CWCreateError(kCWURLUtiltyErrorDomain, code, localizedMessage);
    }

    return nil;
}

@end
