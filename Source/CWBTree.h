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

typedef NSUInteger CWBTreeEnumerationMode;

enum CWBTreeEnumerationMode {
	CWBTreeNodeBreadthFirstSearch = 1,
	CWBTreeNodeDepthFirstSearch = 2
};

@class CWBTreeNode;

typedef NSUInteger (^BTreeNodeValue)(id obj);

@interface CWBTree : NSObject

/**
 The Node Evaluator is a Block you can set so it can return a NSUInteger from a node value
 
 @param (block) id obj the object in the BTree whose NSUInteger value is needed
 */
@property(copy) BTreeNodeValue nodeValueEvaluator;

/**
 Inserts the value into the BTree 
 
 The BTree uses the node evaluator to get the objects NSUInteger value and then inserts
 the object into the appropriate point in the BTree. IF this value is nil then this 
 method just immmediately returns and does nothing.
 
 @param value the object you want inserted into the BTree
 */
-(void)insertValue:(id)value;

/**
 Enumerates the BTree in a given mode, passing a block over each node/value it passes
 
 @param mode this must be either CWBTreeNodeBreadthFirstSearch or CWBTreeNodeDepthFirstSearch
 otherwise this method just exits. If one of the modes is matched then it enumerates 
 over the btree according to the algorithm pattern. 
 
 @param mode the node to enumerate over all the nodes in 
 @param (block) id value the value of the node being enumerated over
 @param (block) node the CWBTreeNode being enumerated over
 @param (block) stop a BOOL pointer you can set to YES to stop the enumeration
 */
-(void)enumerateBTreeInMode:(CWBTreeEnumerationMode)mode 
				  withBlock:(void (^)(id value, CWBTreeNode *node, BOOL *stop))block;

/**
 This method enumerates over the BTree in Breadth First Search
 
 @param mode the node to enumerate over all the nodes in 
 @param (block) id value the value of the node being enumerated over
 @param (block) node the CWBTreeNode being enumerated over
 @param (block) stop a BOOL pointer you can set to YES to stop the enumeration
 */
-(void)enumerateBTreeWithBlock:(void (^)(id value, CWBTreeNode *node, BOOL *stop))block;

/**
 This method gets the NSUInteger value for the object and returns YES if its in the Tree, otherwise returns NO
 
 @param object the object you wish to see if it is in the tree
 @return a BOOL with YES if the obejct is in the tree, otherwise returns NO
 */
-(BOOL)isObjectInTree:(id)object;

/**
 This method is the same to -isObjectInTree but uses a NSUInteger node value
 
 @param nodevalue the nodevalue of an object you wish to see if it is in the tree
 @return a BOOL with YES if the obejct is in the tree, otherwise returns NO
 */
-(BOOL)isNodeValueInTree:(NSUInteger)nodeValue;

@end
