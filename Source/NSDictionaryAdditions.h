/*
//  NSDictionaryAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 11/12/10.
//  Copyright 2010. All rights reserved.
//
 
 */

#import <Foundation/Foundation.h>


@interface NSDictionary (CWNSDictionaryAdditions)

/**
 Ruby Inspired Iterator for NSDictionary in Objective-C
 */
-(void)cw_each:(void (^)(id key, id value, BOOL *stop))block;

/**
 Same as cw_each but operates concurrently and passes in a bool
 pointer allowing you to stop the enumeration
 */
-(void)cw_eachConcurrentlyWithBlock:(void (^)(id key, id value, BOOL *stop))block;

/**
 Simple Convenience method to tell if the dictionary
 contains a particular key
 */
-(BOOL)cw_dictionaryContainsKey:(NSString *)key;

/**
 An dictionary mapping method using only 1 block
 */
-(NSDictionary *)cw_mapDictionary:(NSDictionary* (^)(id key, id value))block;

@end
