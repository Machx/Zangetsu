/*
//  CWBTree.h
//  Zangetsu
//
//  Created by Colin Wheeler on 7/14/11.
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

@interface CWBTreeNode : NSObject
@property(nonatomic, retain) id value;
@property(nonatomic, weak) CWBTreeNode *parent;
@property(nonatomic, retain, readonly) CWBTreeNode *leftNode;
@property(nonatomic, retain, readonly) CWBTreeNode *rightNode;
-(id)initWithValue:(id)aValue;
-(void)assignLeftNode:(CWBTreeNode *)node;
-(void)assignRightNode:(CWBTreeNode *)node;
-(BOOL)isEqualToNode:(CWBTreeNode *)node;
-(NSUInteger)nodeLevel;
@end

@interface CWBTree : NSObject
-(id)initWithRootNodeValue:(id)value;
@property(nonatomic, retain) CWBTreeNode *rootNode;
-(void)enumerateBTreeWithBlock:(void (^)(id nodeValue, id node, BOOL *stop))block;
@end
