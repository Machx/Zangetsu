/*
//  URLUtilities.h
//  Zangetsu
//
//  Created by Colin Wheeler on 2/11/11.
//  Copyright 2012 . All rights reserved.
//
 
 */

#import <Foundation/Foundation.h>

/**
 * Creates a NSURL with the string passed in
 *
 * Creates a URL with the string passed in to create a NSURL object
 *
 * @param url a NSString containing a url address with any additional formatting options you want to create a NSURL object from
 * @return a NSURL object from the string passed in
 */
NSURL *CWURL(NSString * urlFormat,...);

/**
 Creates a authorization header string like "Basic {base64encodedlogin}"
 
 where "{base64encodedlogin}" is your login and password encoded via base64
 encoding. If either the passed in login or password are nil the function
 will throw an assertion.
 
 @param login a NSString with your login identity
 @param password a NSString with the password corresponding to the login identity
 @return a NSString with a value that can be set as the authorization header value or nil if there was a problem
 */
NSString *CWURLAuthorizationHeaderString(NSString *login, NSString *password);

@interface CWURLUtilities : NSObject

/**
 Convenience method to retun an NSError for a http error code
 
 @param code a NSInteger whose code you want to get a NSError with a localized description for
 @return a NSError object if everything was successful or nil if something went wrong
 */
+(NSError *)errorWithLocalizedMessageForStatusCode:(NSInteger)code;
	
@end
