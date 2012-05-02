/*
//  CWBTree.h
//  Zangetsu
//
//  Created by Colin Wheeler on 4/30/12.
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

@interface CWBTree : NSObject

/**
 Sets the value for the given key passed in
 
 Given a non nil key & a value this sets the value in the tree
 for the given key. Otherwise if the key is nil then this method
 immediately exits & does nothing.
 
 @param value any valid NSObject subclass you'd like to have set as the value for a corresponding key
 @param key any non nil NSString value
 */
-(void)setObjectValue:(id)value forKey:(NSString *)aKey;

/**
 Removes the corresponding entry from the receiver BTree
 
 @param aKey any non nil NSString key to be removed from the tree. If this is nil then this method just exits.
 */
-(void)removeObjectValueWithKey:(NSString *)aKey;

/**
 Returns the corresponding value for a given key
 
 @param any non nil NSString value
 @return if successful returns the corresponding value, otherwise returns nil
 */
-(id)objectValueForKey:(NSString *)aKey;

/**
 Enumertes over the contents of the receiving BTree in preorder traversal pattern
 
 This will pass over all nodes in the tree unless the BOOL pointer is set to yes
 at some point before the iteration is over.
 
 @param value (block arguemtn) value of the node 
 @param value (block argument) value of the key
 @param stop (block argument) stop you can set this to YES to stop enumeration
 */
-(void)enumerateOverObjectsWithBlock:(void (^)(id value, NSString *aKey, BOOL *stop))block;

@end
