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
<<<<<<< HEAD
 Ruby Inspired Iterator for NSDictionary in Objective-C	*/
-(void)cw_each:(void (^)(id key, id value, BOOL *stop))block;

/**
 Same as cw_each but operates concurrently and passes in a bool
 pointer allowing you to stop the enumeration	*/
-(void)cw_eachConcurrentlyWithBlock:(void (^)(id key, id value, BOOL *stop))block;

/**
 Simple Convenience method to tell if the dictionary
 contains a particular key	*/
-(BOOL)cw_dictionaryContainsKey:(NSString *)key;

/**
 An dictionary mapping method using only 1 block	*/
=======
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
>>>>>>> upstream/master
-(NSDictionary *)cw_mapDictionary:(NSDictionary* (^)(id key, id value))block;

-(NSDictionary *)cw_filteredDictionaryOfEntriesPassingTest:(BOOL (^)(id key, id value))block;

@end
