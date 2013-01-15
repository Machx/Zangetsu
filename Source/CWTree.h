/*
//  CWTree.h
//  Zangetsu
//
//  Created by Colin Wheeler on 7/12/11.
//  Copyright 2012. All rights reserved.
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

@interface CWTreeNode : NSObject

/**
 Node value
 */
@property(retain) id value;

/**
 Parent Object which is also a CWTreeNode
 */
@property(weak) id parent;

/**
 Children Node Objects
 */
@property(readonly, retain) NSMutableArray *children;

/**
 Key to set if a node allows duplicate children
 */
@property(assign) BOOL allowsDuplicates;

/**
 Initializes and create a new CWTreeNode Object initialized with aValue
 
 This is the prefeered initializer for CWTreeNode.
 
 @param aValue an Objective-C object that the CWTreeNode will retain
 @return a new CWTreeNode with aValue for the nodes data value and no children
 */
-(id)initWithValue:(id)aValue;

/**
 Adds node to the receivers children
 
 If the receiver allows duplicates it simply adds node to the receivers children
 and sets itself as the nodes parent. If the receiver does not allow duplicates 
 then the receiver checks if the node isn't already in its children. If it is 
 not then it checks the node values of its children to make sure there isn't 
 already a node with the same value there if there isn't then it proceeds and 
 adds the node to the receivers chilren and sets itself as the nodes parent.
 
 @param node a CWTreeNode object
 */
-(void)addChild:(CWTreeNode *)node;

/**
 Removes the object from the receivers children
 
 The receiver checks to make sure the node is in its children and if node is,
 then it removes itself as a parent and removes the node from its chilren.
 
 @param a CWTreeNode object
 */
-(void)removeChild:(CWTreeNode *)node;

/**
 Returns if the receivers value & node pointers are all equal to node
 
 Returns a BOOL value if nodes value is equal to the receivers and if its parent
 poiners are equal as well as its children contents. 
 
 @param node a valid CWTreeNode object
 @return YES if all the nodes values all equal
 */
-(BOOL)isEqualToNode:(CWTreeNode *)node;

/**
 Returns a bool value indicating if nodes value is equal to the receivers
 
 @param node a valid CWTreeNode object
 @return a BOOL with yes if the node values are equal, otherwise no.
 */
-(BOOL)isNodeValueEqualTo:(CWTreeNode *)node;

/**
 Returns the depth level of the node in the tree it is in
 
 @return a NSUInteger with the depth level of the node in its graph of nodes
 */
-(NSUInteger)nodeLevel;
@end

@interface CWTree : NSObject

/**
 Initializes & returns a new CWTree object with a root CWTreeNode set to value
 
 @param value any valid Objective-C object to initialize a CWTreeNode node with
 @return a CWTree object with its rootnode pointer pointing at a newly created 
 CWTreeNode object with value as its node value
 */
-(id)initWithRootNodeValue:(id)value;

/**
 Pointer to the root node of the tree of nodes
 */
@property(retain) CWTreeNode *rootNode;

/**
 Enumerates a CWTree object object on a level by level basis.
 
 Enumerates a CWTree object by starting with the root node and then visiting 
 the children. It visits eash level going from left to right and then visiting
 the next level until it has visited all nodes in the tree or until the BOOL 
 stop pointer in the block has been set to YES.
 
 Block values passed back to you are as follows
 @param nodeValue a convenience to accessing (CWTreeNode *)[node nodeValue]
 @param node a pointer to the node being enumerated over
 @param stop a BOOL pointer which you can set to YES to stop enumeration, 
 otherwise it will continue until all nodes have been enumerated over
 */
-(void)enumerateTreeWithBlock:(void (^)(id nodeValue, id node, BOOL *stop))block;

/**
 Returns a bool indicating if the tree object is equal to the receiver tree
 
 @return a BOOL if the receivers children objects are equal to tree's children
 */
-(BOOL)isEqualToTree:(CWTree *)tree;

/**
 Returns a BOOL indicating if the object argument is contained in the receiver
 
 @param object the object you wish to see if its contained in the receiver
 @return YES if object is contained in the block or NO otherwise
 */
-(BOOL)containsObject:(id)object;

/**
 Returns a BOOL indicating if the object argument is contained in the receiver
 
 @param block a block that returns a bool indicating if the object passed in is 
 a match to object
 @return YES if object is contained in the block or NO otherwise
 */
-(BOOL)containsObjectWithBlock:(BOOL(^)(id obj))block;

@end
