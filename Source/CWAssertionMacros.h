/*
//  CWAssertionMacros.h
//  Zangetsu
//
//  Created by Colin Wheeler on 1/14/12.
//  Copyright (c) 2012. All rights reserved.
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

#define CWAssert(expression, ...) \
do { \
	if(!(expression)) { \
		NSLog(@"Assertion Failure '%s' in %s on line %s:%d. %@", #expression, __func__, __FILE__, __LINE__, [NSString stringWithFormat: @"" __VA_ARGS__]); \
		abort(); \
	} \
} while(0)

#define CWAssertST(expression, ...) \
do { \
	if(!(expression)) { \
		NSLog(@"Assertion Failure '%s' in %s on line %s:%d. %@", #expression, __func__, __FILE__, __LINE__, [NSString stringWithFormat: @"" __VA_ARGS__]); \
		NSLog(@"Assertion Failure Stack Trace:\n%@",[NSThread callStackSymbols]); \
		abort(); \
	} \
} while(0)

/**
 CWIBOutletAssert is not a usual assertion macro like the other ones contained
 here. Its purpose is entirely just to be a reminder when launching an app in
 debug mode that certain outlets have not been hooked up so you don't go and
 spend a bunch of time wondering what went wrong in your code :)
 */
#define CWIBOutletAssert(_x_) \
do { \
	if(_x_ == nil) { \
		NSLog(@"IBOutlet Assertion: %s is nil and appears to not be hooked up!",#_x_); \
	} \
} while(0)
