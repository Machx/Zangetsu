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

/**
 returns a bool indicating if you can reach an address given the current configuration
 
 @param address a NSString with the host address you are trying to reach
 @return a BOOL with yes if the address is reachable or no if it is not
 */
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
