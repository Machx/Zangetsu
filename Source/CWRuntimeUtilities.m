/*
//  CWRuntimeUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 3/11/11.
//  Copyright 2012. All rights reserved.
//
 
 Copyright (c) 2012 Colin Wheeler
 
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

#import "CWRuntimeUtilities.h"
#import <objc/runtime.h>

void CWSwizzleInstanceMethods(Class instanceClass, SEL originalSel, SEL newSel, NSError **error) {
	Method originalMethod, newMethod = nil;
	
	originalMethod = class_getInstanceMethod(instanceClass, originalSel);
	if (!originalMethod) {
		if (error) {
			*error = [NSError errorWithDomain:kCWRuntimeErrorDomain
										 code:kCWRuntimeErrorNoOriginalInstanceMethod
									 userInfo:@{ NSLocalizedDescriptionKey : @"No Original Instance Method to swizzle!"
					  }];
		}
		return;
	}
	
	newMethod = class_getInstanceMethod(instanceClass, newSel);
	if (!newMethod) {
		if (error) {
			*error = [NSError errorWithDomain:kCWRuntimeErrorDomain
										 code:kCWRuntimeErrorNoNewInstanceMethod
									 userInfo:@{ NSLocalizedDescriptionKey : @"No New Instance Method to swizzle!"
					  }];
		}
		return;
	}
	
	const char *method1_encoding = method_getTypeEncoding(originalMethod);
	const char *method2_encoding = method_getTypeEncoding(newMethod);
	if (strcmp(method1_encoding, method2_encoding) != 0) {
		if (error) {
			*error = [NSError errorWithDomain:kCWRuntimeErrorDomain
										 code:kCWRuntimeErrorNonMatchingMethodEncodings
									 userInfo:@{ NSLocalizedDescriptionKey :
					  [NSString stringWithFormat:@"Method Encodings don't match: %s != %s",
					   method1_encoding,method2_encoding]
					  }];
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

void CWSwizzleClassMethods(Class methodClass, SEL originalSel, SEL newSel, NSError **error) {
	Method originalMethod, newMethod = nil;
	
	originalMethod = class_getClassMethod(methodClass, originalSel);
	if (!originalMethod) {
		if (error) {
			*error = [NSError errorWithDomain:kCWRuntimeErrorDomain
										 code:kCWRuntimeErrorNoOriginalClassMethod
									 userInfo:@{ NSLocalizedDescriptionKey : @"No Original Class Method to swizzle!"
					  }];
		}
		return;
	}
	
	newMethod = class_getClassMethod(methodClass, newSel);
	if (!newMethod) {
		if (error) {
			*error = [NSError errorWithDomain:kCWRuntimeErrorDomain
										 code:kCWRuntimeErrorNoNewClassMethod
									 userInfo:@{ NSLocalizedDescriptionKey : @"No New Class Instance Method to swizzle!"
					  }];
		}
		return;
	}
	
	const char *method1_encoding = method_getTypeEncoding(originalMethod);
	const char *method2_encoding = method_getTypeEncoding(newMethod);
	if (strcmp(method1_encoding, method2_encoding) != 0) {
		if (error) {
			*error = [NSError errorWithDomain:kCWRuntimeErrorDomain
										 code:kCWRuntimeErrorNonMatchingMethodEncodings
									 userInfo:@{ NSLocalizedDescriptionKey :
					  [NSString stringWithFormat:@"Method Encodings don't match: %s != %s",
					   method1_encoding,method2_encoding]
					  }];
		}
		return;
	}
	
	class_addMethod(methodClass,
					originalSel,
					method_getImplementation(newMethod),
					method_getTypeEncoding(newMethod));
	class_replaceMethod(methodClass,
						newSel,
						method_getImplementation(originalMethod),
						method_getTypeEncoding(originalMethod));
	method_exchangeImplementations(originalMethod, newMethod);
}
