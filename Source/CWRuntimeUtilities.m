/*
//  CWRuntimeUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 3/11/11.
//  Copyright 2012. All rights reserved.
//
 
 */

#import "CWRuntimeUtilities.h"
#import <objc/runtime.h>

Method CWSwizzleInstanceMethods(Class instanceClass, SEL originalSel, SEL newSel, NSError **error)
{
	Method originalMethod, newMethod = nil;
	
	originalMethod = class_getInstanceMethod(instanceClass, originalSel);
	if(!originalMethod){
		if(*error){
			*error = CWCreateError(kCWRuntimeErrorDomain, kCWErrorNoOriginalInstanceMethod, @"No Original Instance Method to swizzle!");
			return nil;
		}
	}
	newMethod = class_getInstanceMethod(instanceClass, newSel);
	if(!newMethod){
		if(*error) {
			*error = CWCreateError(kCWRuntimeErrorDomain, kCWErrorNoNewInstanceMethod, @"No New Instance Method to swizzle!");
			return nil;
		}
	}
	
	method_exchangeImplementations(originalMethod, newMethod);
	return originalMethod;
}

Method CWSwizzleClassMethods(Class methodClass, SEL originalSel, SEL newSel, NSError **error)
{
	Method originalMethod, newMethod = nil;
	
	originalMethod = class_getClassMethod(methodClass, originalSel);
	if(!originalMethod){
		if(*error){
			*error = CWCreateError(kCWRuntimeErrorDomain, kCWErrorNoOriginalClassMethod, @"No Original Class Method to swizzle!");
			return nil;
		}
	}
	newMethod = class_getClassMethod(methodClass, newSel);
	if(!newMethod){
		if(*error){
			*error = CWCreateError(kCWRuntimeErrorDomain, kCWErrorNoNewClassMethod, @"No New Class Method to swizzle!");
			return nil;
		}
	}
	
	method_exchangeImplementations(originalMethod, newMethod);
	return originalMethod;
}
