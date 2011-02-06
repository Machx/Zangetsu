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
void CWInAutoreleasePool(VoidBlock block)
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	block();
	[pool drain];
}
