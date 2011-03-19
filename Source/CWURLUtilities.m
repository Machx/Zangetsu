//
//  URLUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 2/11/11.
//  Copyright 2011. All rights reserved.
//

#import "CWURLUtilities.h"

NSURL* CWURL(NSString *url)
{
	return [NSURL URLWithString:url];
}

static NSString * kCWURLUtiltyErrorDomain = @"com.Zangetsu.CWURLUtilities";

@implementation CWURLUtilities

+(NSError *)errorWithLocalizedMessageForStatusCode:(NSInteger)code
{
	NSString *localizedMessage = [NSHTTPURLResponse localizedStringForStatusCode:code];
	
	if (localizedMessage) {
		return CWCreateError(code,kCWURLUtiltyErrorDomain,localizedMessage);
	}
	
	return nil;
}

@end
