/*
//  CWDebugUtilities.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/11/10.
//  Copyright 2010. All rights reserved.
//
 	*/

#import <Foundation/Foundation.h>

/**
 Returns if the currently running application is being debugged
 discovered at http://lists.apple.com/archives/Xcode-users/2004/Feb/msg00241.html
 this implementation apparently will always say yes when being run
 by Xcode, but no when being run normally in finder
 
 @return a BOOL indicating if the application is being debugged	*/
BOOL CWIsDebugInProgress(void);

/**
 Intentionally crashes the application
 ONLY USE THIS IN DEBUGGING YOUR APP!!! 
 NEVER INCLUDE THIS IN A SHIPPING PRODUCTION APP IN RELEASE MODE!!!
 When run from within Xcode this actually triggers lldb breaking on
 the line that intentionally caused the crash.	*/
void CWCrash(void);

/**
 Executes the block only if the debug preprocessor
 is defined
 
 @param block a block to be executed only if the application is being debugged	*/
void CWInDebugOnly(void(^DebugBlock)(void));

/**
 Classic Nanosecond timing code, but now uses a 
 block to abstract away the details of the timing code
 so now you can just use the function as is.
 
 @return a double with the amount of nanoseconds it took to execute the block	*/
double CWNanoSecondsToExecuteCode(void(^TimeBlock)(void));

/**
 Returns in MilliSeconds the amount of time the code
 contained inside the Timing Block took to execute.

 @return a double with the ammount of milliseconds it took to execute the block	*/
double CWMilliSecondsToExecuteCode(void(^TimeBlock)(void));

/**
 Returns the call stack symbols as a NSString instead
 of a NSArray. If used with an NSException it does not
 include the Exception handling frames.
 
 @return a NSString with the stack trace returned from [NSThread callStackSymbols]	*/
NSString *CWStackTrace(void);
