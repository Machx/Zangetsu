/*
//  CWTrie.h
//  Zangetsu
//
//  Created by Colin Wheeler on 4/15/12.
//  Copyright (c) 2012. All rights reserved.
//
 	*/

#import <Foundation/Foundation.h>

static NSString *const kZangetsuTrieErrorDomain = @"com.Zangetsu.CWTrie";

static const NSUInteger kNilLookupCharacter = 442;
static const NSUInteger kEmptyLookupString = 443;

@interface CWTrie : NSObject

/**
 Sets the Trie to be case sensitive or not for looking up/setting keys
 
 By default Tries are case sensitive.	*/
@property(assign) BOOL caseSensitive;

/**
 Returns the object value for a given key
 
 If a given key exists in a trie instance then this method will return
 the corresponding value for that key. Otherwise this method will
 return nil if there is no value for the corresponding key or if the
 key doesn't exist in the trie instance.
 
 @param aKey a NSString that corresponds to a key in the trie
 @return the corresponding value to a given key or nil	*/
-(id)objectValueForKey:(NSString *)aKey;

/**
 Sets a object value corresponding to the given key
 
 This stores the value in a Trie format for a given key. For example
 If we were to store the value 1 for the key "Tent" and 2 for "Tennis"
 the node layout would look like
 
 [Root] -> [T] -> [e] -> [n] -> [t(1)]
                           \ -> [n] -> [i] -> [s(2)]	*/
-(void)setObjectValue:(id)aObject 
			   forKey:(NSString *)aKey;

/**
 Removes a object value for a given key
 
 This method essentially calls [self setObjectValue:nil forKey:aKey]
 setting nil for a given key	*/
-(void)removeObjectValueForKey:(NSString *)aKey;

@end
