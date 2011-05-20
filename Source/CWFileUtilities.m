//
//  CWFileUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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

+(NSString *)temporaryFile {
	NSString *temporaryFilePath = nil;
	
	NSString *basePath = NSTemporaryDirectory();
	NSString *file = [NSString stringWithFormat:@"%@.temp",[NSString cw_uuidString]];
	
	temporaryFilePath = [NSString stringWithFormat:@"%@%@", basePath, file];
	
	return temporaryFilePath;
}

@end
