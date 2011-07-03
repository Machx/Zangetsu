//
//  CWBlockFoundation.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/11/10.
//  Copyright 2010. All rights reserved.
//

#import "CWBlockFoundation.h"

/**
 CW_10_7_REMOVE_API
 WARNING: THIS API WILL BE REMOVED WHEN THE PROJECT SWITCHES TO 10.7
 AS THE SDK BECAUSE OF THE NEW @AUTORELEASEPOOL{} SYNTAX
 
 Runs the passed in block in a NSAutoreleasePool and then
 drains the autoreleasepool
 
 @param block a block to be executed after creation of a autorelease pool and before the pool is released
 */
void CWInAutoreleasePool(VoidBlock block)
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	block();
	[pool drain];
}
