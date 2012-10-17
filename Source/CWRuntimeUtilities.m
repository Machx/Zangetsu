/*
//  CWRuntimeUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 3/11/11.
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

#import "CWRuntimeUtilities.h"
#import <objc/runtime.h>

void CWSwizzleInstanceMethods(Class instanceClass, SEL originalSel, SEL newSel, NSError **error)
{
	Method originalMethod, newMethod = nil;
	
	originalMethod = class_getInstanceMethod(instanceClass, originalSel);
	if(!originalMethod){
		if(*error){
			*error = CWCreateError(kCWRuntimeErrorDomain,
								   kCWErrorNoOriginalInstanceMethod,
								   @"No Original Instance Method to swizzle!");
		}
	}
	
	newMethod = class_getInstanceMethod(instanceClass, newSel);
	if(!newMethod){
		if(*error) {
			*error = CWCreateError(kCWRuntimeErrorDomain,
								   kCWErrorNoNewInstanceMethod,
								   @"No New Instance Method to swizzle!");
		}
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

void CWSwizzleClassMethods(Class methodClass, SEL originalSel, SEL newSel, NSError **error)
{
	Method originalMethod, newMethod = nil;
	
	originalMethod = class_getClassMethod(methodClass, originalSel);
	if(!originalMethod){
		if(*error){
			*error = CWCreateError(kCWRuntimeErrorDomain,
								   kCWErrorNoOriginalClassMethod,
								   @"No Original Class Method to swizzle!");
		}
	}
	newMethod = class_getClassMethod(methodClass, newSel);
	if(!newMethod){
		if(*error){
			*error = CWCreateError(kCWRuntimeErrorDomain,
								   kCWErrorNoNewClassMethod,
								   @"No New Class Method to swizzle!");
			return;
		}
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
