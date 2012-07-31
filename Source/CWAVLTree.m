/*
//  CWAVLTree.m
//  Zangetsu
//
//  Created by Colin Wheeler on 7/31/12.
//
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

#import "CWAVLTree.h"

@interface AVLNode : NSObject
@property(retain) id var;
@property(retain) AVLNode *left;
@property(retain) AVLNode *right;
@property(weak)   AVLNode *parent;
@end

@implementation AVLNode

-(id)init
{
	self = [super init];
	if (self) {
		_var = nil;
		_left = nil;
		_right = nil;
		_parent = nil;
	}
	return self;
}

@end

//=============================================
// AVLTree
//=============================================

#define kLeftDirection 1
#define kRightDirection -1

NSInteger _levelCountOfDescendentsFromNode(AVLNode *node);
NSInteger weightOfNode(AVLNode *node);
NSComparisonResult compareObjects(id obj1,id obj2, NSComparator comparitor);

@interface CWAVLTree()
@property(readwrite, assign) NSUInteger count;
@property(retain) AVLNode *root;
@end

@implementation CWAVLTree

- (id)init
{
    self = [super init];
    if (self) {
		_root = nil;
		_comparitor = [^(id obj1, id obj2){
			return [obj1 compare:obj2];
		} copy];
    }
    return self;
}

NSComparisonResult compareObjects(id obj1,id obj2, NSComparator comparitor)
{
	SEL compareSelector = @selector(compare:);
	if ([obj1 respondsToSelector:compareSelector] &&
		[obj2 respondsToSelector:compareSelector]) {
		return [obj1 compare:obj2];
	}
	if (comparitor) {
		return comparitor(obj1,obj2);
	}
	return NSOrderedSame;
}

NSInteger weightOfNode(AVLNode *node)
{
	NSInteger leftWeight = _levelCountOfDescendentsFromNode(node.left);
	NSInteger rightWeight = _levelCountOfDescendentsFromNode(node.right);
	return (leftWeight - rightWeight);
}

NSInteger _levelCountOfDescendentsFromNode(AVLNode *node)
{
	if(node == nil) { return 0; }
	NSInteger leftCount = _levelCountOfDescendentsFromNode(node.left);
	NSInteger rightCount = _levelCountOfDescendentsFromNode(node.right);
	NSInteger maxSubDepth = MAX(leftCount, rightCount);
	return 1 + maxSubDepth;
}

-(void)addObject:(id)object
{
	NSLog(@"Inserting %@...",object);
	if (self.root == nil) {
		AVLNode *node = [[AVLNode alloc] init];
		node.var = object;
		self.root = node;
		NSLog(@"Set Root ");
		return;
	}
	
	AVLNode *currentNode = self.root;
	AVLNode *currentParentNode = nil;
	NSInteger direction = 0;
	while (currentNode) {
		NSComparisonResult compare = compareObjects(currentNode.var, object, self.comparitor);
		if (compare == NSOrderedAscending) {
			currentParentNode = currentNode;
			currentNode = currentNode.right;
			direction = kRightDirection;
			NSLog(@"Going Right -->>");
			continue;
		} else if (compare == NSOrderedDescending) {
			currentParentNode = currentNode;
			currentNode = currentNode.left;
			direction = kLeftDirection;
			NSLog(@"<<-- Going Left");
			continue;
		} else if (compare == NSOrderedSame) {
			NSLog(@"Items are the same");
			return;
		}
	}
	
	AVLNode *node = [[AVLNode alloc] init];
	node.var = object;
	node.parent = currentParentNode;
	
	if (direction == kRightDirection) {
		currentParentNode.right = node;
		currentNode = node;
	} else if (direction == kLeftDirection) {
		currentParentNode.left = node;
		currentNode = node;
	}
	
	while (currentNode) {
		NSInteger weight = weightOfNode(currentNode);
		NSLog(@"Node Weight: %lu",weight);
		if (weight > 1 || weight < -1) {
			//need to balance tree
		}
		currentNode = currentNode.parent;
	}
}

-(void)removeObject:(id)object
{
	
}

-(BOOL)objectIsInTree:(id)object
{
	return NO;
}

@end
