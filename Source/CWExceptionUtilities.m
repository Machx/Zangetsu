/*
//  CWExceptionUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 1/29/11.
//  Copyright 2012. All rights reserved.
//
 
 */

#import "CWExceptionUtilities.h"

#if Z_HOST_OS_IS_MAC_OS_X
void CWShowExceptionAsAlertPanel(NSException *exception)
{
	NSInteger result = NSRunCriticalAlertPanel(@"Application Error Occurred",
											   [NSString stringWithFormat:@"Uncaught Exception: %@\n%@\n%@",[exception name], [exception reason],[exception cw_stackTrace]],
											   @"Continue", @"Quit", nil);
	if (result == NSAlertAlternateReturn) {
		[[NSApplication sharedApplication] terminate:nil];
	}
}
#endif

@implementation NSException (CWNSExceptionAdditions)

-(NSString *)cw_stackTrace
{
	return CWStackTrace();
}

@end
