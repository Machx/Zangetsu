/*
//  NSObject+AssociatedObjects.h
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

#import <Foundation/Foundation.h>

@interface NSObject (Zangetsu_NSObject_AssociatedObjects)

/**
 Returns the value associated with a key
 
 @param key that was used to associate an object with the receiver
 @return the value associated with the given key
 */
-(id)cw_valueAssociatedWithKey:(void *)key;

/**
 Associates the value with a key using a strong reference
 
 @param value the object to be associated with the receiver
 @param atomic specificies if the value should be set atomically
 @param key to be used to lookup value later
 */
-(void)cw_associateValue:(id)value
				  atomic:(BOOL)atomic
				 withKey:(void *)key;

/**
 Associates the value with a key by copying it and using a strong reference
 
 @param value the object to be associated with the receiver
 @param atomic specificies if the value should be set atomically
 @param key to be used to lookup value later
 */
-(void)cw_associateValueByCopyingValue:(id)value
								atomic:(BOOL)atomic
							   withKey:(void *)key;

/**
 Associates the value with a key using a weak reference
 
 @param value the object to be associated with the receiver
 @param key to be used to lookup value later
 */
-(void)cw_associateWeakValue:(id)value
					 withKey:(void *)key;

@end
