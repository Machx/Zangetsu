//
//  URLUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 2/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CWURLUtilities.h"

static NSString * kCWURLUtiltyErrorDomain = @"com.Zangetsu.CWURLUtilities";

@implementation CWURLUtilities

+(NSError *)errorWithLocalizedMessageForStatusCode:(NSInteger)code
{
	NSError *httpError = nil;
	
	NSString *localizedMessage = [NSHTTPURLResponse localizedStringForStatusCode:code];
	
	if (localizedMessage) {
		httpError = CWCreateError(code,kCWURLUtiltyErrorDomain,localizedMessage);
	}
	
	return httpError;
}

@end
