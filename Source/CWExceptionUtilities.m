//
//  CWExceptionUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 1/29/11.
//  Copyright 2011. All rights reserved.
//

#import "CWExceptionUtilities.h"

void CWReportException(NSException *exception)
{
	[NSApp reportException:exception];
}

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

-(NSString *)cw_stackTrace
{
	NSMutableString *trace = [NSMutableString string];
	
	NSArray *symbols = [NSThread callStackSymbols];
	
	for (NSString *symbol in symbols) {
		[trace appendString:symbol];
		[trace appendString:@"\n"];
	}

	return trace;
}

@end