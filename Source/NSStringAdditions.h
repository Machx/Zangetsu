/*
//  NSStringAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 11/5/10.
//  Copyright 2010. All rights reserved.
//
 
 */

#import <Foundation/Foundation.h>

@interface NSString (CWNSStringAdditions) 
/**
 Convenience method for Core Foundations CFUUIDCreate() function
 */
+ (NSString *)cw_uuidString;
/**
 Asynchronous & Synchronous string enumeration 
 this method was created for being able to enumerate over all the lines
 in a string asychronously, but make the whole operation of enumerating 
 over all the lines, synchronous
 */
- (void)cw_enumerateConcurrentlyWithOptions:(NSStringEnumerationOptions)options
                                 usingBlock:(void (^)(NSString *substring))block;
/**
 Escapes entities that would need to be escaped in urls
 */
- (NSString *) cw_escapeEntitiesForURL;
/**
 Quick test for an empty string
 */
- (BOOL) cw_isNotEmptyString;
@end
