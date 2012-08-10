/*
//  CWExceptionUtilities.h
//  Zangetsu
//
//  Created by Colin Wheeler on 1/29/11.
//  Copyright 2012. All rights reserved.
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


#if Z_HOST_OS_IS_MAC_OS_X
#import <Cocoa/Cocoa.h>
#else
#import <Foundation/Foundation.h>
#endif

#if Z_HOST_OS_IS_MAC_OS_X
/**
 Takes a NSException object and runs an Critical Alert Panel with the Exception 
 information as well as the stack trace of where the stack trace occurred minus
 the exception handling frames.
 */
void CWShowExceptionAsAlertPanel(NSException *exception);
#endif

@interface NSException (CWNSExceptionAdditions)
/**
 Calls CWStackTrace() to return NSThreads callStackSymbols
 and put them in string form.
 */
-(NSString *)cw_stackTrace;
@end

