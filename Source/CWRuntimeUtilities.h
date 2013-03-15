/*
//  CWRuntimeUtilities.h
//  Zangetsu
//
//  Created by Colin Wheeler on 3/11/11.
//  Copyright 2012. All rights reserved.
//
 	*/

#import <Foundation/Foundation.h>

static NSString *const kCWRuntimeErrorDomain = @"com.Zangetsu.CWRuntimeUtilities";

static const NSInteger kCWErrorNoOriginalInstanceMethod = 201;
static const NSInteger kCWErrorNoNewInstanceMethod = 202;
static const NSInteger kCWErrorNoOriginalClassMethod = 203;
static const NSInteger kCWErrorNoNewClassMethod = 204;
static const NSInteger kCWErrorNonMatchingMethodEncodings = 205;

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
<<<<<<< HEAD
 @return the original Objective-C Method implementation if successfull or nil if not successfull	*/
Method CWSwizzleInstanceMethods(Class instanceClass, SEL originalSel, SEL newSel, NSError **error);
=======
 */
void CWSwizzleInstanceMethods(Class instanceClass,
							  SEL originalSel,
							  SEL newSel,
							  NSError **error);
>>>>>>> upstream/master

/**
 Swizzles the Class Method implementations
 
 Attempts to get the method implementations for the selectors on the class 
 specified and swizzles them. If it can't get either method implementations then
 it writes to error and returns. Otherwise it exchanges the implementations.
 
 @param methodClass The Class whose class methods you are swizzling
 @param originalSel The original method you are swizzling
 @param newSel The New method you are swizzling
 @param error an error object to write to if something goes wrong
<<<<<<< HEAD
 @return the original Objective-C Method implementation if successfull or nil if not successfull	*/
Method CWSwizzleClassMethods(Class methodClass, SEL originalSel, SEL newSel, NSError **error);
=======
 */
void CWSwizzleClassMethods(Class methodClass,
						   SEL originalSel,
						   SEL newSel,
						   NSError **error);
>>>>>>> upstream/master
