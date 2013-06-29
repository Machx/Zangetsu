/*
//  CWDebugUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/11/10.
//  Copyright 2010. All rights reserved.
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
