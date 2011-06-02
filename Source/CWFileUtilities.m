//
//  CWFileUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/20/11.
//  Copyright 2011. All rights reserved.
//

#import "CWFileUtilities.h"


@implementation CWFileUtilities

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

/**
 Returns a NSString path to a temporary file
 
 Uses NSTemporaryDirectory() and the cw_uuidString method to create a unique
 path for a temporary file. 
 
 @return a NSString with the full path to a temporary file with a unique name and .temp extension
 */
+(NSString *)temporaryFilePath {
	NSString *temporaryFilePath = nil;
	
	NSString *basePath = NSTemporaryDirectory();
	NSString *file = [NSString stringWithFormat:@"%@.temp",[NSString cw_uuidString]];
	
	temporaryFilePath = [NSString stringWithFormat:@"%@%@", basePath, file];
	
	return temporaryFilePath;
}

@end
