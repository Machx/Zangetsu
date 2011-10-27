/*
//  CWReachability.m
//  Zangetsu
//
//  Created by Colin Wheeler on 3/26/11.
//  Copyright 2011. All rights reserved.
//
 
 Copyright (c) 2011 Colin Wheeler
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

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
	
	bool available = false;
	bool success = false;
	SCNetworkReachabilityFlags flags;
	SCNetworkReachabilityRef reachable = SCNetworkReachabilityCreateWithName(NULL, [address UTF8String]);
	
	success = SCNetworkReachabilityGetFlags(reachable, &flags);
	available = success && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
	
	return (available) ? YES : NO;
}

@end
