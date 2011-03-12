//
//  CWRuntimeUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 3/11/11.
//  Copyright 2011. All rights reserved.
//

#import "CWRuntimeUtilities.h"
#import <objc/runtime.h>

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

BOOL CWSwizzleClassMethods(Class methodClass, SEL originalSel, SEL newSel, NSError **error)
{
	Method originalMethod, newMethod = nil;
	
	originalMethod = class_getClassMethod(methodClass, originalSel);
	if(!originalMethod){
		if(*error){
			*error = CWCreateError(101, @"com.Zangetsu.CWRuntimeUtilities", @"No Original Class Method to swizzle!");
		}
	}
	
	newMethod = class_getClassMethod(methodClass, newSel);
	if(!newMethod){
		if(*error){
			*error = CWCreateError(101, @"com.Zangetsu.CWRuntimeUtilities", @"No New Class Method to swizzle!");
		}
	}
	
	method_exchangeImplementations(originalMethod, newMethod);
	
	return YES;
}
