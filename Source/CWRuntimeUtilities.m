//
//  CWRuntimeUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 3/11/11.
//  Copyright 2011. All rights reserved.
//

#import "CWRuntimeUtilities.h"
#import <objc/runtime.h>

/**
 Swizzles the Instance Method implementations
 
 Attempts to get the method implementations for the selectors on the class specified and swizzles them. If
 it can't get either method implementations then it writes to error and returns NO. Otherwise it exchanges
 the implementations and returns YES.
 
 @param methodClass The Class whose class methods you are swizzling
 @param originalSel The original method you are swizzling
 @param newSel The New method you are swizzling
 @param error an error object to write to if something goes wrong
 @return a BOOL indicating success (YES) or failure (NO) to swizzle the methods
 */
BOOL CWSwizzleInstanceMethods(Class instanceClass, SEL originalSel, SEL newSel, NSError **error)
{
	Method originalMethod, newMethod = nil;
	
	originalMethod = class_getInstanceMethod(instanceClass, originalSel);
	if(!originalMethod){
		if(*error){
			*error = CWCreateError(101, @"com.Zangetsu.CWRuntimeUtilities", @"No Original Instance Method to swizzle!");
			return NO;
		}
	}
	
	newMethod = class_getInstanceMethod(instanceClass, newSel);
	if(!newMethod){
		if(*error) {
			*error = CWCreateError(102, @"com.Zangetsu.CWRuntimeUtilities", @"No New Instance Method to swizzle!");
			return NO;
		}
	}
	
	method_exchangeImplementations(originalMethod, newMethod);
	
	return YES;
}

/**
 Swizzles the Class Method implementations
 
 Attempts to get the method implementations for the selectors on the class specified and swizzles them. If
 it can't get either method implementations then it writes to error and returns NO. Otherwise it exchanges
 the implementations and returns YES.
 
 @param methodClass The Class whose class methods you are swizzling
 @param originalSel The original method you are swizzling
 @param newSel The New method you are swizzling
 @param error an error object to write to if something goes wrong
 @return a BOOL indicating success (YES) or failure (NO) to swizzle the methods
 */
BOOL CWSwizzleClassMethods(Class methodClass, SEL originalSel, SEL newSel, NSError **error)
{
	Method originalMethod, newMethod = nil;
	
	originalMethod = class_getClassMethod(methodClass, originalSel);
	if(!originalMethod){
		if(*error){
			*error = CWCreateError(103, @"com.Zangetsu.CWRuntimeUtilities", @"No Original Class Method to swizzle!");
			return NO;
		}
	}
	
	newMethod = class_getClassMethod(methodClass, newSel);
	if(!newMethod){
		if(*error){
			*error = CWCreateError(104 , @"com.Zangetsu.CWRuntimeUtilities", @"No New Class Method to swizzle!");
			return NO;
		}
	}
	
	method_exchangeImplementations(originalMethod, newMethod);
	
	return YES;
}
