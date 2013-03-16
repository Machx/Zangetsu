/*
//  CWTrie.h
//  Zangetsu
//
//  Created by Colin Wheeler on 4/15/12.
//  Copyright (c) 2012. All rights reserved.
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

static NSString *const kZangetsuTrieErrorDomain = @"com.Zangetsu.CWTrie";

static const NSUInteger kNilLookupCharacterErrorCode = 442;
static const NSUInteger kEmptyLookupStringErrorCode = 443;

@interface CWTrie : NSObject

/**
 Sets the Trie to be case sensitive or not for looking up/setting keys
 
 By default Tries are case sensitive.
 */
@property(assign) BOOL caseSensitive;

/**
 Returns the object value for a given key
 
 If a given key exists in a trie instance then this method will return
 the corresponding value for that key. Otherwise this method will
 return nil if there is no value for the corresponding key or if the
 key doesn't exist in the trie instance.
 
 @param aKey a NSString that corresponds to a key in the trie
 @return the corresponding value to a given key or nil
 */
-(id)objectValueForKey:(NSString *)aKey;

/**
 Sets a object value corresponding to the given key
 
 This stores the value in a Trie format for a given key. For example
 If we were to store the value 1 for the key "Tent" and 2 for "Tennis"
 the node layout would look like
 
 [Root] -> [T] -> [e] -> [n] -> [t(1)]
                           \ -> [n] -> [i] -> [s(2)]
 */
-(void)setObjectValue:(id)aObject 
			   forKey:(NSString *)aKey;

/**
 Removes a object value for a given key
 
 This method essentially calls [self setObjectValue:nil forKey:aKey]
 setting nil for a given key
 */
-(void)removeObjectValueForKey:(NSString *)aKey;

@end
