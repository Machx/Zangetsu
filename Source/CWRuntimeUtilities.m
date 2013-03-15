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

void CWSwizzleInstanceMethods(Class instanceClass, SEL originalSel, SEL newSel, NSError **error) {
	Method originalMethod, newMethod = nil;
	
	originalMethod = class_getInstanceMethod(instanceClass, originalSel);
	if (CWErrorTrap(!originalMethod, ^NSError *{
		return CWCreateError(kCWRuntimeErrorDomain,kCWErrorNoOriginalInstanceMethod,
							 @"No Original Instance Method to swizzle!"); }, error)) {
		return;
	}
	
	newMethod = class_getInstanceMethod(instanceClass, newSel);
	if (CWErrorTrap(!newMethod, ^NSError *{
		return CWCreateError(kCWRuntimeErrorDomain,kCWErrorNoNewInstanceMethod,
							 @"No New Instance Method to swizzle!"); }, error)) {
		return;
	}
	
	const char *method1_encoding = method_getTypeEncoding(originalMethod);
	const char *method2_encoding = method_getTypeEncoding(newMethod);
	if (CWErrorTrap(!strcmp(method1_encoding, method2_encoding), ^NSError *{
		return CWCreateError(kCWRuntimeErrorDomain, kCWErrorNonMatchingMethodEncodings,
							 [NSString stringWithFormat:@"Method Encodings don't match: %s != %s",
							  method1_encoding,method2_encoding]); }, error)) {
		return;
	}
	
	if (class_addMethod(instanceClass,
						originalSel,
						method_getImplementation(newMethod),
						method_getTypeEncoding(newMethod))) {
		class_replaceMethod(instanceClass,newSel,
							method_getImplementation(originalMethod),
							method_getTypeEncoding(originalMethod));
	} else {
		method_exchangeImplementations(originalMethod, newMethod);
	}
}

void CWSwizzleClassMethods(Class methodClass, SEL originalSel, SEL newSel, NSError **error) {
	Method originalMethod, newMethod = nil;
	
	originalMethod = class_getClassMethod(methodClass, originalSel);
	if (CWErrorTrap(!originalMethod, ^NSError *{
		return CWCreateError(kCWRuntimeErrorDomain, kCWErrorNoOriginalClassMethod,
							 @"No Original Class Method to swizzle!"); }, error)) {
		return;
	}
	
	newMethod = class_getClassMethod(methodClass, newSel);
	if (CWErrorTrap(!newMethod, ^NSError *{
		return CWCreateError(kCWRuntimeErrorDomain, kCWErrorNoNewClassMethod,
							 @"No New Class Method to swizzle!"); }, error)) {
		return;
	}
	
	const char *method1_encoding = method_getTypeEncoding(originalMethod);
	const char *method2_encoding = method_getTypeEncoding(newMethod);
	if (CWErrorTrap(!strcmp(method1_encoding, method2_encoding), ^NSError *{
		return CWCreateError(kCWRuntimeErrorDomain, kCWErrorNonMatchingMethodEncodings,
							 [NSString stringWithFormat:@"Method Encodings don't match: %s != %s",
								method1_encoding,method2_encoding]); }, error)) {
		return;
	}
	
	if (class_addMethod(methodClass,
						originalSel,
						method_getImplementation(newMethod),
						method_getTypeEncoding(newMethod))) {
		class_replaceMethod(methodClass,
							originalSel,
							method_getImplementation(originalMethod),
							method_getTypeEncoding(originalMethod));
	} else {
		method_exchangeImplementations(originalMethod, newMethod);
	}
}
