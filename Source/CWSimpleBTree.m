/*
//  CWBTree.m
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

#import "CWSimpleBTree.h"

@implementation CWSimpleBTreeNode

@synthesize value = _value;
@synthesize parent = _parent;
@synthesize leftNode = _leftNode;
@synthesize rightNode = _rightNode;

-(id)initWithValue:(id)aValue
{
    self = [super init];
    if (self) {
        _value = aValue;
        _parent = nil;
        _leftNode = nil;
        _rightNode = nil;
    }
    return self;
}

/**
 checks if the node values & their left/right node pointers are equal
 
 @return a BOOL indicating if the nove value and its pointers are equal
 */
-(BOOL)isEqualToNode:(CWSimpleBTreeNode *)node
{	
	if ([node.value isEqual:self.value] &&
		[node.leftNode isEqual:self.leftNode] &&
		[node.rightNode isEqual:self.rightNode]) {
		return YES;
	}
    return NO;
}

/**
 Performs the necessary validation before assigning the nodes left pointer value
 */
-(void)setLeftNode:(CWSimpleBTreeNode *)node
{
	node.parent = self;
	_leftNode = node;
}

/**
 Performs the necessary validation before assigning the nodes right pointer value
 */
-(void)setRightNode:(CWSimpleBTreeNode *)node
{
	node.parent = self;
	_rightNode = node;
}

/**
 Returns the nodes depth in the CWBTree its contained in
 
 Returns N + 1 where N is the number of parent nodes the receiving node
 has. If the node has no parent notes it simply returns 1. The number 
 returned from this will always be >= 1.
 
 @return a NSUInteger with the node Level the receive node is at in its containing CWBTree
 */
-(NSUInteger)nodeLevel
{
    NSUInteger level = 1;
    CWSimpleBTreeNode *currentParrent = self.parent;
    while (currentParrent) {
        level++;
        currentParrent = currentParrent.parent;
    }
    return level;
}

@end

@implementation CWSimpleBTree

@synthesize rootNode = _rootNode;

/**
 initialzes a CWBTree with the root node set to nil
 
 @return a fully iniitalized CWBTree with rootNode set to nil
 */
-(id)init 
{
    self = [super init];
    if (self) {
        _rootNode = nil;
    }
    return self;
}

/**
 initializes the CWBTree with a root node value
 
 Internally it create a CWBTreeNode with the value if it is non nil. Otherwise
 the root node is never created and set to nil.
 
 @param value a non nil value to be used in creating a CWBTreeNode
 @return a CWBTree with a root node assigned and wrapped in the value provided if value is non nil
 */
-(id)initWithRootNodeValue:(id)value
{
    self = [super init];
    if (self){
        if (value) {
            CWSimpleBTreeNode *node = [[CWSimpleBTreeNode alloc] initWithValue:value];
            _rootNode = node;
        }
    }
    return self;
}

/**
 eumerates the CWBTree in a iterative preorder traversal pattern. 
 
 Internally it uses a stack to navigate each node  and then calls the block on 
 each node it visits. If there is no root node this method detects that and 
 simply returns having done nothing.
 
 @param block a block to be called when visiting each node in the tree
 */
-(void)enumerateBTreeWithBlock:(void (^)(id nodeValue, id node, BOOL *stop))block
{	
	if(!self.rootNode) { return; }
	
	__block BOOL shouldStop = NO;
	
	CWStack *nodes = [[CWStack alloc] init];
	[nodes push:self.rootNode];
	
	CWSimpleBTreeNode *currentNode = nil;
	while (!nodes.isEmpty) {
		currentNode = [nodes pop];
		
		if (currentNode.rightNode)
			[nodes push:currentNode.rightNode];
		
		if(currentNode.leftNode)
			[nodes push:currentNode.leftNode];
		
		block(currentNode.value, currentNode, &shouldStop);
		if (shouldStop) { return; }
	}
}

@end
