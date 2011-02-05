//
//  CWDebugUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/11/10.
//  Copyright 2010. All rights reserved.
//

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
 When run from within Xcode this actually triggers gdb breaking on
 the line that intentionally caused the crash.
 */
void CWCrash()
{
	__builtin_trap();
}

void CWInDebugOnly(DebugBlock block)
{
#ifdef DEBUG
	block();
#endif
}

uint64_t CWNanoSecondsToExecuteCode(DebugBlock block)
{
	uint64_t start = mach_absolute_time();
	
	block();
	
	uint64_t end = mach_absolute_time();
	
	uint64_t elapsed = end - start;
	
	mach_timebase_info_data_t info;
	mach_timebase_info(&info);
	uint64_t nanoSeconds = elapsed * info.numer / info.denom;
	
	return nanoSeconds;
}

NSString *CWStackTrace(void)
{
	NSMutableString *trace = [NSMutableString string];
	
	NSArray *symbols = [NSThread callStackSymbols];
	
	for (NSString *symbol in symbols) {
		[trace appendString:symbol];
		[trace appendString:@"\n"];
	}
	
	return trace;
}