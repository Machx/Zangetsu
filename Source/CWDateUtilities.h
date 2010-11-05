//
//  CWDateUtilities.h
//  NilTracker
//
//  Created by Colin Wheeler on 10/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CWDateUtilities : NSObject {}

+(NSDate *)dateFromISO8601String:(NSString *)dateString;

@end
