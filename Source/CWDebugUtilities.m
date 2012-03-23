/*
//  CWDebugUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/11/10.
//  Copyright 2010. All rights reserved.
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

#import "CWDebugUtilities.h"

/*for CWIsDebugInProgress() */
#include <sys/sysctl.h>
#include <unistd.h>
#include <err.h>
#include <errno.h>
#include <stdio.h>

/*for the timing block*/
#import <stdarg.h>
#import <mach/mach.h>
#import <mach/mach_time.h>
#import <unistd.h>

/**
 Returns if the currently running application is being debugged
 discovered at http://lists.apple.com/archives/Xcode-users/2004/Feb/msg00241.html
 this implementation apparently will always say yes when being run
 by Xcode, but no when being run normally in finder
 
 @return a BOOL indicating if the application is being debugged
 */
BOOL CWIsDebugInProgress()
{
	int mib[4];
	size_t bufSize = 0;
	struct kinfo_proc kp;
	
	mib[0] = CTL_KERN;
	mib[1] = KERN_PROC;
	mib[2] = KERN_PROC_PID;
	mib[3] = getpid();
	
	bufSize = sizeof (kp);
	
	if ((sysctl(mib, 4, &kp, &bufSize, NULL, 0)) < 0) {
		perror("Failure calling sysctl");
		return NO;
	}
	
	return (kp.kp_proc.p_flag & P_TRACED) != 0;
}

/**
 Intentionally crashes the application
 ONLY USE THIS IN DEBUGGING YOUR APP!!! 
 NEVER INCLUDE THIS IN A SHIPPING PRODUCTION APP IN RELEASE MODE!!!
 When run from within Xcode this actually triggers lldb breaking on
 the line that intentionally caused the crash.
 */
void CWCrash()
{
	__builtin_trap();
}

/**
 Executes the block only if the debug preprocessor
 is defined
 
 @param block a block to be executed only if the application is being debugged
 */
void CWInDebugOnly(void(^DebugBlock)(void))
{
#ifdef DEBUG
	DebugBlock();
#endif
}

/**
 Classic Nanosecond timing code, but now uses a 
 block to abstract away the details of the timing code
 so now you can just use the function as is.
 
 @return a uint64_t with the amount of nanoseconds it took to execute the block
 */
uint64_t CWNanoSecondsToExecuteCode(void(^TimeBlock)(void))
{
	uint64_t start = mach_absolute_time();
	TimeBlock();
	uint64_t end = mach_absolute_time();
	uint64_t elapsed = end - start;
	mach_timebase_info_data_t info;
	mach_timebase_info(&info);
	uint64_t nanoSeconds = elapsed * info.numer / info.denom;
	return nanoSeconds;
}

/**
 Returns the call stack symbols as a NSString instead
 of a NSArray. If used with an NSException it does not
 include the Exception handling frames.
 
 @return a NSString with the stack trace returned from [NSThread callStackSymbols]
 */
NSString *CWStackTrace(void) 
{
	NSString *trace = [[NSThread callStackSymbols] description];
	return trace;
}
