/*
//  URLUtilities.h
//  Zangetsu
//
//  Created by Colin Wheeler on 2/11/11.
//  Copyright 2012 . All rights reserved.
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

#import <Foundation/Foundation.h>

/**
 Creates a NSURL with the string passed in
 
 @param url a NSString containing a url address (additonal formatting optional)
 @return a NSURL object from the string passed in
 */
NSURL *CWURL(NSString * urlFormat,...);

/**
 Creates a authorization header string like "Basic {base64encodedlogin}"
 
 where "{base64encodedlogin}" is your login and password encoded via base64
 encoding. If either the passed in login or password are nil the function
 will log an error message and immediately return.
 
 @param login a NSString with your login identity
 @param password a NSString with the password for the login identity
 @return NSString formatted to be the authorization header string or nil
 */
NSString *CWURLAuthorizationHeaderString(NSString *login, NSString *password);

@interface CWURLUtilities : NSObject

/**
 Convenience method to retun an NSError for a http error code
 
 @param code a NSInteger with the status code
 @return a NSError object or nil if something went wrong
 */
+(NSError *)errorWithLocalizedMessageForStatusCode:(NSInteger)code;
	
@end
