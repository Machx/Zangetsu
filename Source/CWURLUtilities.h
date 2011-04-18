//
//  URLUtilities.h
//  Zangetsu
//
//  Created by Colin Wheeler on 2/11/11.
//  Copyright 2011 . All rights reserved.
//

#import <Cocoa/Cocoa.h>

NSURL *CWURL(NSString * urlFormat,...);

@interface CWURLUtilities : NSObject {}

+(NSError *)errorWithLocalizedMessageForStatusCode:(NSInteger)code;
	
@end
