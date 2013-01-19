/*
//  CWExceptionUtilities.h
//  Zangetsu
//
//  Created by Colin Wheeler on 1/29/11.
//  Copyright 2012. All rights reserved.
//
 	*/


#if Z_HOST_OS_IS_MAC_OS_X
#import <Cocoa/Cocoa.h>
#else
#import <Foundation/Foundation.h>
#endif

#if Z_HOST_OS_IS_MAC_OS_X
/**
 Takes a NSException object and runs an Critical Alert Panel with the Exception 
 information as well as the stack trace of where the stack trace occurred minus
 the exception handling frames.	*/
void CWShowExceptionAsAlertPanel(NSException *exception);
#endif

@interface NSException (CWNSExceptionAdditions)
/**
 Calls CWStackTrace() to return NSThreads callStackSymbols
 and put them in string form.	*/
-(NSString *)cw_stackTrace;
@end

