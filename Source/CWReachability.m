//
//  CWReachability.m
//  Zangetsu
//
//  Created by Colin Wheeler on 3/26/11.
//  Copyright 2011. All rights reserved.
//

#import "CWReachability.h"
#import <SystemConfiguration/SystemConfiguration.h>

@implementation CWReachability

- (id) init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    return self;
}

+ (BOOL) canReachAddress:(NSString *)address {
    NSParameterAssert(address);

    SCNetworkReachabilityFlags flags;
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, [address UTF8String]);

    BOOL gotFlags = SCNetworkReachabilityGetFlags(reachability, &flags);

    CFMakeCollectable(reachability);

    if (gotFlags) {
        if (flags & kSCNetworkReachabilityFlagsReachable) {
            return YES;
        }
		return NO;
    }

    return NO;
}

@end
