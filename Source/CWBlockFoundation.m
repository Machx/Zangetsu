//
//  CWBlockFoundation.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/11/10.
//  Copyright 2010. All rights reserved.
//

#import "CWBlockFoundation.h"

/**
 Runs the passed in block in a NSAutoreleasePool and then
 drains the autoreleasepool
 */
void inAutoreleasePool(VoidBlock block)
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	block();
	[pool drain];
}

/**
 Test method for right now.
 Performs the kvo notifications willChangeValueForKey:
 then executes the block where you can do assignment,
 and then performs didChangeValueForKey:
 */
void CWKVONotifyAndAssign(NSString *key,VoidBlock block)
{
	NSParameterAssert(key);
	[self willChangeValueForKey:key];
	block();
	[self didChangeValueForKey:key];
}
