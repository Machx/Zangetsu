/*
//  CWBTree.m
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

#import "CWBTree.h"
#import "CWStack.h"

#define BTREENODE_NULLVALUE 0

enum CWBTreeNodeVals {
	kCWLeftNode = 1,
	kCWRightNode = 2
};
	
@interface CWBTreeNode : NSObject
@property(retain) id data;
@property(assign) NSUInteger nodeValue;
@property(retain) CWBTreeNode *left;
@property(retain) CWBTreeNode *right;
@end

@implementation CWBTreeNode

@synthesize data = _data;
@synthesize nodeValue = _nodeValue;
@synthesize left = _left;
@synthesize right = _right;

- (id)init
{
    self = [super init];
    if (self) {
        _data = nil;
		_nodeValue = BTREENODE_NULLVALUE;
		_left = nil;
		_right = nil;
    }
    return self;
}

-(NSString *)description
{
	NSString *desc = [NSString stringWithFormat:@"Node->Value: %@",_data];
	return desc;
}

@end

@interface CWBTree ()
@property(retain) id rootNode;
-(void)enumerateBTreeBreadthFirstSearchWithBlock:(void (^)(id value, CWBTreeNode *node, BOOL *stop))block;
-(void)enumerateBTreeDepthFirstSearchWithBlock:(void (^)(id value, CWBTreeNode *node, BOOL *stop))block;
@end

@implementation CWBTree

@synthesize rootNode = _rootNode;
@synthesize nodeValueEvaluator = _nodeValueEvaluator;

- (id)init
{
    self = [super init];
    if (self) {
		_rootNode = nil;
		_nodeValueEvaluator = [^(id nodeObject){
			if ([nodeObject isKindOfClass:[CWBTreeNode class]]) {
				CWBTreeNode *node = (CWBTreeNode *)nodeObject;
				return [node.data intValue];
			}
			if ([nodeObject respondsToSelector:@selector(intValue)]) {
				return [nodeObject intValue];
			}
			return [nodeObject hash];
		} copy];
    }
    return self;
}

-(void)insertValue:(id)value
{
	if (value == nil) { return; }
	
	//we have no nodes so insert the root
	if (!self.rootNode) {
		CWBTreeNode *node = [[CWBTreeNode alloc] init];
		node.data = value;
		node.nodeValue = self.nodeValueEvaluator(value);
		self.rootNode = node;
		return;
	}
	
	NSUInteger nodeValue = self.nodeValueEvaluator(value);
	
	CWBTreeNode *current = self.rootNode;
	NSUInteger currentNodeValue = self.nodeValueEvaluator(current.data);
	
	while ( nodeValue != currentNodeValue ) {
		if ((nodeValue > currentNodeValue) && current.right) {
			current = current.right;
		} else if((nodeValue < currentNodeValue) && current.left) {
			current = current.left;
		} else {
			break;
		}
		currentNodeValue = self.nodeValueEvaluator(current);
	}
	
	if (currentNodeValue == nodeValue) {
		CWDebugLog(@"Trying to insert an already inserted value into the BTree");
		return;
	}
	
	CWBTreeNode *node = [[CWBTreeNode alloc] init];
	node.data = value;
	node.nodeValue = self.nodeValueEvaluator(value);
	
	if (node.nodeValue > currentNodeValue) {
		current.right = node;
	} else {
		current.left = node;
	}
}

-(BOOL)isObjectInTree:(id)object
{
	if(!object || !self.rootNode) { return NO; }
	
	NSUInteger objectValue = 0;
	if ([object isKindOfClass:[CWBTreeNode class]]) {
		CWBTreeNode *aNode = (CWBTreeNode *)object;
		objectValue = self.nodeValueEvaluator(aNode.data);
	} else {
		objectValue = self.nodeValueEvaluator(object);
	}
	
	BOOL result = [self isNodeValueInTree:objectValue];
	return result;
}

-(BOOL)isNodeValueInTree:(NSUInteger)nodeValue
{	
	if((nodeValue == 0) || !self.rootNode) { 
		return NO; 
	}
	
	CWBTreeNode *currentNode = self.rootNode;
	NSUInteger currentNodeValue = self.nodeValueEvaluator(currentNode.data);
	
	if (currentNodeValue == nodeValue) { return YES; }
	
	while (nodeValue != currentNodeValue) {
		BOOL direction = (nodeValue > currentNodeValue) ? kCWRightNode : kCWLeftNode;
		if ((direction == kCWRightNode) && currentNode.right) {
			currentNode = currentNode.right;
		} else if((direction == kCWLeftNode) && currentNode.left) {
			currentNode = currentNode.left;
		} else {
			break;
		}
		currentNodeValue = self.nodeValueEvaluator(currentNode.data);
	}
	
	if (nodeValue == currentNodeValue) { 
		return YES; 
	}
	
	return NO;
}

-(void)enumerateBTreeWithBlock:(void (^)(id value, CWBTreeNode *node, BOOL *stop))block
{
	[self enumerateBTreeBreadthFirstSearchWithBlock:block];
}

-(void)enumerateBTreeInMode:(CWBTreeEnumerationMode)mode withBlock:(void (^)(id value, CWBTreeNode *node, BOOL *stop))block
{
	if (mode == CWBTreeNodeBreadthFirstSearch) {
		[self enumerateBTreeBreadthFirstSearchWithBlock:block];
	} else if(mode == CWBTreeNodeDepthFirstSearch) {
		[self enumerateBTreeDepthFirstSearchWithBlock:block];
	} else {
		CWDebugLog(@"Error tried to enumerate BTreee in unknown mode");
	}
}

-(void)enumerateBTreeBreadthFirstSearchWithBlock:(void (^)(id value, CWBTreeNode *node, BOOL *stop))block
{
	if (!self.rootNode) { return; }
	
	BOOL shouldStop = NO;
	CWQueue *queue = [[CWQueue alloc] init];
	[queue enqueue:self.rootNode];
	
	while ( !queue.isEmpty ) {
		CWBTreeNode *node = [queue dequeue];
		block(node.data, node, &shouldStop);
		if (shouldStop == YES) {
			break;
		}
		if (node.left) {
			[queue enqueue:node.left];
		}
		if (node.right) {
			[queue enqueue:node.right];
		}
	}
}

-(void)enumerateBTreeDepthFirstSearchWithBlock:(void (^)(id value, CWBTreeNode *node, BOOL *stop))block
{
	if (!self.rootNode) { return; }
	
	BOOL shouldStop = NO;
	CWStack *stack = [[CWStack alloc] init];
	[stack push:self.rootNode];
	
	while ( !stack.isEmpty ) {
		CWBTreeNode *node = [stack pop];
		block(node.data, node, &shouldStop);
		if (shouldStop == YES) {
			break;
		}
		if (node.right) {
			[stack push:node.right];
		}
		if (node.left) {
			[stack push:node.left];
		}
	}
}

@end
