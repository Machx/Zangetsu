/*
//  NSRecursiveLock+NSRecursiveLockAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/17/11.
//  Copyright (c) 2012. All rights reserved.
//
 	*/

#import <Foundation/Foundation.h>

@interface NSRecursiveLock (CWNSRecursiveLockAdditions)
/**
 Executes the lock method on the instance, executes the block, 
 and then executes the unlock method on the instance lock.
 
 @param block the block you wish to be executed between locking & unlock the instance lock	*/
-(void)cw_doWithLock:(dispatch_block_t)block;
@end
