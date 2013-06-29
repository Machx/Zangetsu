/*
//  CWRuntimeUtilities.h
//  Zangetsu
//
//  Created by Colin Wheeler on 3/11/11.
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

#import <Foundation/Foundation.h>

static NSString *const kCWRuntimeErrorDomain = @"com.Zangetsu.CWRuntimeUtilities";

static const NSInteger kCWRuntimeErrorNoOriginalInstanceMethod = 201;
static const NSInteger kCWRuntimeErrorNoNewInstanceMethod = 202;
static const NSInteger kCWRuntimeErrorNoOriginalClassMethod = 203;
static const NSInteger kCWRuntimeErrorNoNewClassMethod = 204;
static const NSInteger kCWRuntimeErrorNonMatchingMethodEncodings = 205;

//so we don't have to include <objc/runtime.h> here in this header
typedef struct objc_method *Method;

/**
 Swizzles the Instance Method implementations
 
 Attempts to get the method implementations for the selectors on the class 
 specified and swizzles them. If it can't get either method implementations then
 it writes to error & returns. Otherwise it exchanges the implementations.
 
 @param methodClass The Class whose class methods you are swizzling
 @param originalSel The original method you are swizzling
 @param newSel The New method you are swizzling
 @param error an error object to write to if something goes wrong
 */
void CWSwizzleInstanceMethods(Class instanceClass,
							  SEL originalSel,
							  SEL newSel,
							  NSError **error);

/**
 Swizzles the Class Method implementations
 
 Attempts to get the method implementations for the selectors on the class 
 specified and swizzles them. If it can't get either method implementations then
 it writes to error and returns. Otherwise it exchanges the implementations.
 
 @param methodClass The Class whose class methods you are swizzling
 @param originalSel The original method you are swizzling
 @param newSel The New method you are swizzling
 @param error an error object to write to if something goes wrong
 */
void CWSwizzleClassMethods(Class methodClass,
						   SEL originalSel,
						   SEL newSel,
						   NSError **error);
