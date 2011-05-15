//
//  CWApplicationRegistry.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/15/11.
//  Copyright 2011. All rights reserved.
//

#import "CWApplicationRegistry.h"


@implementation CWApplicationRegistry

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+(BOOL)applicationIsRunning:(NSString *)appName {
	BOOL isRunning = NO;
	NSArray *applications = [[NSWorkspace sharedWorkspace] runningApplications];
	
	isRunning = [applications cw_isObjectInArrayWithBlock:^BOOL(id obj) {
		if ([[obj localizedName] isEqualToString:appName]) {
			return YES;
		}
		return NO;
	}];
	
	return isRunning;
}

@end
