/*
//  NSRecursiveLock+NSRecursiveLockAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/17/11.
//  Copyright (c) 2012. All rights reserved.
//
 	*/

#import "NSRecursiveLockAdditions.h"

@implementation NSRecursiveLock (CWNSRecursiveLockAdditions)

-(void)cw_doWithLock:(dispatch_block_t)block
{
	[self lock];
	block();
	[self unlock];
}

@end
