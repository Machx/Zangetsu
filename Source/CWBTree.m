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

@interface CWBTreeNode : NSObject
@property(nonatomic, retain) NSString *key;
@property(nonatomic, retain) id value;
@property(nonatomic, retain) CWBTreeNode *leftNode;
@property(nonatomic, retain) CWBTreeNode *rightNode;
@end

CWBTreeNode *CWBTreeNodeMinimumNode(CWBTreeNode *node)
{
	if (!node.leftNode) {
		return node;
	} else {
		return CWBTreeNodeMinimumNode(node.leftNode);
	}
}

CWBTreeNode *CWBTreeNodeRemove(NSString *aKey,CWBTreeNode *node,CWBTreeNode *parent)
{
	if ([aKey compare:node.key] == NSOrderedAscending) {
		if (node.leftNode) {
			return CWBTreeNodeRemove(aKey, node.leftNode, node);
		} else {
			return nil;
		}
	} else if([aKey compare:node.key] == NSOrderedDescending) {
		if (node.rightNode) {
			return CWBTreeNodeRemove(aKey, node.rightNode, node);
		} else {
			return nil;
		}
	} else {
		if (node.leftNode && node.rightNode) {
			CWBTreeNode *min = CWBTreeNodeMinimumNode(node.rightNode);
			node.key = min.key;
			node.value = min.value;
			return CWBTreeNodeRemove(aKey, node.rightNode, node);
			
		} else if([parent.leftNode isEqual:node]){
			parent.leftNode = (node.leftNode) ? node.leftNode : node.rightNode;
			return node;
			
		} else if ([parent.rightNode isEqual:node]) {
			parent.rightNode = (node.leftNode) ? node.leftNode : node.rightNode;
			return node;
		}
	}
	return nil;
}

@implementation CWBTreeNode

@synthesize key = _key;
@synthesize value = _value;
@synthesize leftNode = _leftNode;
@synthesize rightNode = _rightNode;

- (id)init
{
    self = [super init];
    if (self) {
		_key = nil;
        _value = nil;
		_leftNode = nil;
		_rightNode = nil;
    }
    return self;
}

@end

@interface CWBTree ()
@property(nonatomic,retain) CWBTreeNode *rootNode;
@end

@implementation CWBTree

@synthesize rootNode = _rootNode;

- (id)init
{
    self = [super init];
    if (self) {
        _rootNode = nil;
    }
    return self;
}

-(id)objectValueForKey:(NSString *)aKey
{
	if(!aKey) {
		CWDebugLog(@"Error: nil key");
		return nil;
	}
	
	CWBTreeNode *node = self.rootNode;
	
	while (node) {
		if ([node.key isEqualToString:aKey]) {
			return node.value;
		} else if([node.key compare:aKey] == NSOrderedAscending) {
			node = node.leftNode;
		} else {
			node = node.rightNode;
		}
	}
	
	return nil;
}

-(void)setObjectValue:(id)value forKey:(NSString *)aKey
{
	if(!aKey) {
		CWDebugLog(@"Error: aKey is nil");
		return;
	}
	
	if (!self.rootNode) {
		CWBTreeNode *node = [[CWBTreeNode alloc] init];
		node.value = value;
		node.key = aKey;
		self.rootNode = node;
	}
	
	CWBTreeNode *currentNode = self.rootNode;
	
	while (currentNode) {
		if ([currentNode.key isEqualToString:aKey]){
			if (![currentNode.value isEqual:value]) {
				currentNode.value = value;
			}
			return;
		} else {
			if ([aKey compare:currentNode.key] == NSOrderedAscending) {
				if (!currentNode.leftNode) {
					CWBTreeNode *node = [[CWBTreeNode alloc] init];
					node.value = value;
					node.key = aKey;
					currentNode.leftNode = node;
					return;
				} else {
					currentNode = currentNode.leftNode;
				}
			} else {
				if (!currentNode.rightNode) {
					CWBTreeNode *node = [[CWBTreeNode alloc] init];
					node.value = value;
					node.key = aKey;
					currentNode.rightNode = node;
				} else {
					currentNode = currentNode.rightNode;
				}
			}
		}
	}
}

-(void)removeObjectValueWithKey:(NSString *)aKey
{
	if (!self.rootNode) { return; }
	if (!aKey) {
		CWDebugLog(@"Error: key is nil");
		return;
	}
	
	if ([self.rootNode.key isEqualToString:aKey]) {
		CWBTreeNode *root = [[CWBTreeNode alloc] init];
		root.leftNode = self.rootNode;
		CWBTreeNode *removedNode = CWBTreeNodeRemove(aKey, self.rootNode, root);
		self.rootNode = root.leftNode;
		if (removedNode) {
			CWDebugLog(@"success in removing node");
		} else {
			CWDebugLog(@"Failed to remove node");
		}
	} else {
		CWBTreeNodeRemove(aKey, self.rootNode, nil);
	}
}

-(void)enumerateOverObjectsWithBlock:(void (^)(id value, NSString *key, BOOL *stop))block
{
	if (!self.rootNode) { return; }
	
	BOOL shouldStop = NO;
	CWStack *stack = [[CWStack alloc] init];
	[stack push:self.rootNode];
	while (!stack.isEmpty) {
		CWBTreeNode *currentNode = stack.pop;
		block(currentNode.value,currentNode.key,&shouldStop);
		if (shouldStop == YES) { break; }
		if (currentNode.leftNode) {
			[stack push:currentNode.leftNode];
		}
		if (currentNode.rightNode) {
			[stack push:currentNode.rightNode];
		}
	}
}

@end
