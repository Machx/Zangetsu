/*
//  CWExceptionUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 1/29/11.
//  Copyright 2012. All rights reserved.
//
 
 Copyright (c) 2013, Colin Wheeler
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 - Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "CWExceptionUtilities.h"

#if Z_HOST_OS_IS_MAC_OS_X
void CWShowExceptionAsAlertPanel(NSException *exception) {
	NSInteger result = NSRunCriticalAlertPanel(@"Application Error Occurred",
											   [NSString stringWithFormat:@"Uncaught Exception: %@\n%@\n%@",
												exception.name, exception.reason, [exception cw_stackTrace]],
											   @"Continue", @"Quit", nil);
	if (result == NSAlertAlternateReturn) [[NSApplication sharedApplication] terminate:nil];
}
#endif

@implementation NSException (CWNSExceptionAdditions)

-(NSString *)cw_stackTrace {
	return CWStackTrace();
}

@end
