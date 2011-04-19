//
//  URLUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 2/11/11.
//  Copyright 2011. All rights reserved.
//

#import "CWURLUtilities.h"

/**
 * Creates a NSURL with the string passed in
 *
 * Creates a URL with the string passed in to create a NSURL object
 *
 * @param url a NSString containing a url address with any additional formatting options you want to create a NSURL object from
 * @return a NSURL object from the string passed in
 */
NSURL *CWURL(NSString * urlFormat,...){
	
	va_list args;
    va_start(args, urlFormat);
	
	NSString *urlString = [[NSString alloc] initWithFormat:urlFormat arguments:args];
	
	va_end(args);
	
	NSURL *_urlValue = [NSURL URLWithString:urlString];

    return _urlValue;
}

static NSString * kCWURLUtiltyErrorDomain = @"com.Zangetsu.CWURLUtilities";

@implementation CWURLUtilities

+ (NSError *) errorWithLocalizedMessageForStatusCode:(NSInteger)code {
    NSString * localizedMessage = [NSHTTPURLResponse localizedStringForStatusCode:code];

    if (localizedMessage) {
        return CWCreateError(code, kCWURLUtiltyErrorDomain, localizedMessage);
    }

    return nil;
}

@end
