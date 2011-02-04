//
//  CWExceptionUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 1/29/11.
//  Copyright 2011. All rights reserved.
//

#import "CWExceptionUtilities.h"

/**
 Quick method to make the NSApp report the exception
 */
void CWReportException(NSException *exception)
{
	[NSApp reportException:exception];
}

/**
 Takes a NSException object and runs an Critical Alert Panel with the Exception 
 information as well as the stack trace of where the stack trace occurred minus
 the exception handling frames.
 */
void CWShowExceptionAsAlertPanel(NSException *exception)
{
	NSInteger result = NSRunCriticalAlertPanel(@"Application Error Occurred",
											   [NSString stringWithFormat:@"Uncaught Exception: %@\n%@\n%@",[exception name], [exception reason],[exception cw_stackTrace]],
											   @"Continue", @"Quit", nil);
	if (result == NSAlertAlternateReturn) {
		[[NSApplication sharedApplication] terminate:nil];
	}
}

@implementation NSException (CWNSExceptionAdditions)

/**
 Calls CWStackTrace() to return NSThreads callStackSymbols
 and put them in string form.
 */
-(NSString *)cw_stackTrace
{
	return CWStackTrace();
}

@end