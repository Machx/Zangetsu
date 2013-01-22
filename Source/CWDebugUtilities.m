/*
//  CWDebugUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/11/10.
//  Copyright 2010. All rights reserved.
//

Copyright (c) 2012 Colin Wheeler

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


BOOL CWIsDebugInProgress() {
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

void CWCrash() {
	__builtin_trap();
}

void CWInDebugOnly(void(^DebugBlock)(void)) {
#ifdef DEBUG
	DebugBlock();
#endif
}

double CWNanoSecondsToExecuteCode(void(^TimeBlock)(void)) {
	uint64_t start = mach_absolute_time();
	TimeBlock();
	uint64_t end = mach_absolute_time();
	uint64_t elapsed = end - start;
	mach_timebase_info_data_t info;
	mach_timebase_info(&info);
	double nanoSeconds = elapsed * info.numer / info.denom;
	return nanoSeconds;
}

double CWMilliSecondsToExecuteCode(void(^TimeBlock)(void)) {
	double nanoSeconds = CWNanoSecondsToExecuteCode(TimeBlock);
	return (1.0 * 10e-6 * nanoSeconds);
}

NSString *CWStackTrace(void) {
	return [[NSThread callStackSymbols] description];
}
