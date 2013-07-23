/*
//  CWErrorUtilities.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/23/10.
//  Copyright 2010. All rights reserved.
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

static NSString * const kCWErrorDomain = @"CWErrorDomain";

/**
 Convenience method for creating a NSError Object
 
 Easy convenience method to create a NSError Object. It checks for the error 
 message and throws an assertion if it's missing, allows for a string with 
 formatting and passing arguments for the formatting of a string. If no domain 
 is passed in it defaults to kCWErrorDomain.
 
 @param domain the domain for a NSError object
 @param errorCode the error code in a NSError object
 @param errorMessageFormat a string format which sets NSLocalizedDescriptionKey
 @return a NSError object with the values passed in
 */
NSError * CWCreateError(NSString * domain,
						NSInteger errorCode,
						NSString * errorMessageFormat, ...);

/**
 Convenience method for creating a NSError Object
 
 Easy convenience method to create a NSError Object. This method is similar to 
 CWCreateError(), but it also allows setting userInfo dictionary entries. 
 It checks for the error message and throws an assertion if it's missing, allows
 for a string with formatting and passing arguments for the formatting of a
 string. If no domain is passed in it defaults to kCWErrorDomain.
 
 @param domain the domain for a NSError object
 @param errorCode the error code in a NSError object
 @param info a dictionary to be added to the error
 @param errorMessageFormat string formatting for NSLocalizedDescriptionKey
 @return a NSError object with the values passed in
 */
NSError * CWCreateErrorWithUserInfo(NSString * domain,
									NSInteger errorCode,
									NSDictionary *info,
									NSString * errorMessageFormat, ...);
