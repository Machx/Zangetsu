/*
//  NSDictionaryAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 11/12/10.
//  Copyright 2010. All rights reserved.
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

#import <Foundation/Foundation.h>


@interface NSDictionary (CWNSDictionaryAdditions)

/**
 Ruby Inspired Enumerator for NSDictionary Key/Value Pairs in Objective-C
 
 @param key the current key being enumerated over
 @param value the value corresponding to the current key being enumerated over
 @param stop BOOL pointer which you can set to YES to stop enumeration
 */
-(void)cw_each:(void (^)(id key, id value, BOOL *stop))block;

/**
 Concurrent Enumeration of NSDictionary Key/Value pairs
 
 This method is equivalent to enumerating using the Foundation API 
 -enumerateKeysAndObjectsWithOptions passing in NSEnumerationConcurrent
 
 @param key the current key being enumerated over
 @param value the value corresponding to the current key being enumerated over
 @param stop BOOL pointer which you can set to YES to stop enumeration
 */
-(void)cw_eachConcurrentlyWithBlock:(void (^)(id key, id value, BOOL *stop))block;

/**
 Returns a BOOL inicating if the key passed in is contained in the receiver
 
 @return a BOOL with YES if the key was found in the receiver, otherwise NO
 */
-(BOOL)cw_containsKey:(NSString *)key;

/**
 Map one dictionary to another
 
 This works by enumerating over the contents of a NSDictionary and allows you to
 return a new NSDictionary object from the block whose key/value pairs should be
 added to the dictionary returned from this method. If you do not want to map 
 any key/value pair to the dictionary, then simply return nil in the block.
 
 @param key the key currently being enumerated over
 @param value the value corresponding to the key currently being enumerated over
 @param a NSDictionary with the keys/values returned from the block calls
 */
-(NSDictionary *)cw_mapDictionary:(NSDictionary* (^)(id key, id value))block;

/**
 Appends keys & values from one dictionary to another & returns a new instance
 
 This method takes the receiver dictionary and creates a mutable copy, appends
 the keys and values from the argument dictionary, and then then returns to you
 a new NSDictionary instance containing keys and values from both dictionaries.
 
 @param dictionary the keys and values you wish to append to the reciver
 @return a new NSDictionary instance containing keys/values from both instances
 */
-(NSDictionary *)cw_dictionaryByAppendingDictionary:(NSDictionary *)dictionary;

/**
 Returns a new dictionary with key/value pairs from the receiver passing test
 
 This method creates a new NSDictionary instance and finds all entries in the
 receiver dictionary that pass the block test, adds those to the new dictionary
 and then returns that new dictionary at the end of the method.
 
 The block takes in the key and value pairs from the receiver dictionary and
 passes them to you for evaluation. If you return YES then that key/value pair
 is added to the new NSDictionary instance, otherwise if you return NO then
 it will be omitted from the dictionary returned.
 
 @param block must not be nil. use in evaluating key/value pairs
 @return a new NSDictionary with the key/value pairs that passed the block test
 */
-(NSDictionary *)cw_filteredDictionaryOfEntriesPassingTest:(BOOL (^)(id key, id value))block;

@end
