/*
//  URLUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 2/11/11.
//  Copyright 2012. All rights reserved.
//
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
