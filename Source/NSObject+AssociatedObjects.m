/*
//  NSObject+AssociatedObjects.m
//  Zangetsu
//
//  Created by Colin Wheeler on 8/16/13.
//
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

#import "NSObject+AssociatedObjects.h"
#import <objc/runtime.h>

@implementation NSObject (Zangetsu_NSObject_AssociatedObjects)

-(id)cw_valueAssociatedWithKey:(void *)key {
	return objc_getAssociatedObject(self, key);
}

-(void)cw_associateValue:(id)value
				  atomic:(BOOL)atomic
				 withKey:(void *)key {
	objc_AssociationPolicy policty = (atomic ? OBJC_ASSOCIATION_RETAIN : OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	objc_setAssociatedObject(self, key, value, policty);
}

-(void)cw_associateValueByCopyingValue:(id)value
								atomic:(BOOL)atomic
							   withKey:(void *)key {
	objc_AssociationPolicy policy = (atomic ? OBJC_ASSOCIATION_COPY : OBJC_ASSOCIATION_COPY_NONATOMIC);
	objc_setAssociatedObject(self, key, value, policy);
}

-(void)cw_associateWeakValue:(id)value withKey:(void *)key {
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

@end
