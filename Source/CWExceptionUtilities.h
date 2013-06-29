/*
//  CWExceptionUtilities.h
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


#if Z_HOST_OS_IS_MAC_OS_X
#import <Cocoa/Cocoa.h>
#else
#import <Foundation/Foundation.h>
#endif

#if Z_HOST_OS_IS_MAC_OS_X
/**
 Displays the information in a NSException object as an alert panel
 
 Takes a NSException object and runs an Critical Alert Panel with the Exception 
 information as well as the stack trace of where the stack trace occurred minus
 the exception handling frames. The user has an opportunity to quit the app
 with the alert panel triggered in this api.
 
 @param exception this objects info will be displayed as an alert panel
 */
void CWShowExceptionAsAlertPanel(NSException *exception);
#endif

@interface NSException (CWNSExceptionAdditions)
/**
 Calls CWStackTrace() to return NSThreads callStackSymbols
 and put them in string form.
 
 @return a NSString containing NSThreards callStackSymbols
 */
-(NSString *)cw_stackTrace;
@end

