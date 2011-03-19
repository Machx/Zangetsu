//
//  URLUtilities.h
//  Zangetsu
//
//  Created by Colin Wheeler on 2/11/11.
//  Copyright 2011 . All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define CWURL(_URL_) [NSURL URLWithString:_URL_]

@interface CWURLUtilities : NSObject {}

+(NSError *)errorWithLocalizedMessageForStatusCode:(NSInteger)code;
	
@end
