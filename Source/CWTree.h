/*
//  CWTree.h
//  Zangetsu
//
//  Created by Colin Wheeler on 7/12/11.
//  Copyright 2011. All rights reserved.
//
 
 Copyright (c) 2011 Colin Wheeler
 
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

@interface CWTreeNode : NSObject
//vars
@property(nonatomic, retain) id value;
@property(nonatomic, weak) id parent;
@property(nonatomic, readonly, retain) NSMutableArray *children;
@property(nonatomic, assign) BOOL allowsDuplicates;
//methods
-(id)initWithValue:(id)aValue;
-(void)addChild:(CWTreeNode *)node;
-(void)removeChild:(CWTreeNode *)node;
//comparisons
-(BOOL)isEqualToNode:(CWTreeNode *)node;
-(BOOL)isNodeValueEqualTo:(CWTreeNode *)node;
//other properties
-(NSUInteger)nodeLevel;
@end

@interface CWTree : NSObject
-(id)initWithRootNodeValue:(id)value;
@property(nonatomic, retain) CWTreeNode *rootNode;
-(void)enumerateTreeWithBlock:(void (^)(id nodeValue, id node, BOOL *stop))block;
-(BOOL)isEqualToTree:(CWTree *)tree;
@end
