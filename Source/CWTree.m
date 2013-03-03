/*
//  CWTree.m
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

#import "CWTree.h"

@interface CWTreeNode()
@property(readwrite, retain) NSMutableArray *children;
@end

@implementation CWTreeNode

/**
 Initializes and creates a new CWTreenode Object
 
 @return a CWTreeNode object with no value
 */
-(id)init {
    self = [super init];
    if (!self) return nil;
	
	_value = nil;
	_children = [[NSMutableArray alloc] init];
	_parent = nil;
	_allowsDuplicates = YES;
	
    return self;
}

-(id)initWithValue:(id)aValue {
    self = [super init];
    if (!self) return nil;
	
	_value = aValue;
	_children = [[NSMutableArray alloc] init];
	_parent = nil;
	
    return self;
}

/**
 Returns a NSString with the description of the receiving CWTreeNode Object
 
 @return a NSString with debug information on the receiving CWTreeNode Object
 */
-(NSString *)description {
	return [NSString stringWithFormat:@"%@ Node\nValue: %@\nParent: %@\nChildren: %@\nAllows Duplicates: %@",
			NSStringFromClass([self class]),
			[self.value description],
			[self.parent description],
			[self.children description],
			(self.allowsDuplicates ? @"YES" : @"NO")];
}


-(void)addChild:(CWTreeNode *)node {
	if(!node) return;
	
	if (self.allowsDuplicates) {
		node.parent = self;
		[self.children addObject:node];
	} else {
		if (![self.children containsObject:node]) {
			__block BOOL anyNodeContainsValue = NO;
			[self.children enumerateObjectsUsingBlock:^(CWTreeNode *obj, NSUInteger idx, BOOL *stop) {
				if ([obj.value isEqual:node.value]) {
					anyNodeContainsValue = YES;
					*stop = YES;
				}
			}];
			if (!anyNodeContainsValue) {
				node.parent = self;
				node.allowsDuplicates = NO;
				[self.children addObject:node];
			}
		}
	}
}


-(void)removeChild:(CWTreeNode *)node {
	if (node && [self.children containsObject:node]) {
		node.parent = nil;
		[self.children removeObject:node];
	}
}

-(BOOL)isEqualToNode:(CWTreeNode *)node {
	if ([node.value isEqual:self.value]   &&
		(self.parent == node.parent || [node.parent isEqual:self.parent]) &&
		[node.children isEqual:self.children]) {
		return YES;
	}
    return NO;
}

-(BOOL)isNodeValueEqualTo:(CWTreeNode *)node {
    if ([node.value isEqual:self.value]) {
        return YES;
    }
    return NO;
}

-(NSUInteger)nodeLevel {
    NSUInteger level = 1;
    CWTreeNode *currentNode = self.parent;
    while (currentNode) {
        level++;
        currentNode = currentNode.parent;
    }
    return level;
}

@end

@implementation CWTree

-(id)initWithRootNodeValue:(id)value {
    self = [super init];
    if (self) {
        _rootNode = [[CWTreeNode alloc] initWithValue:value];
    }
    return self;
}

-(BOOL)isEqualToTree:(CWTree *)tree {
	if (tree && [self.rootNode isEqualToNode:tree.rootNode]) return YES;
    return NO;
}

-(void)enumerateTreeWithBlock:(void (^)(id nodeValue, id node, BOOL *stop))block {
	if(!self.rootNode) return;
	
	CWQueue *queue = [[CWQueue alloc] init];
	BOOL shouldStop = NO;
	
	[queue enqueue:self.rootNode];
	while (queue.count > 0) {
		CWTreeNode *node = (CWTreeNode *)[queue dequeue];
		block(node.value, node, &shouldStop);
		if(shouldStop) break;
		if (node.children.count > 0) {
			for (CWTreeNode *childNode in node.children) {
				[queue enqueue:childNode];
			}
		}
	}
}

-(BOOL)containsObject:(id)object {
	__block BOOL contains = NO;
	[self enumerateTreeWithBlock:^(id nodeValue, id node, BOOL *stop) {
		if ([object isEqual:nodeValue]) {
			contains = YES;
			*stop = YES;
		}
	}];
	return contains;
}

-(BOOL)containsObjectWithBlock:(BOOL(^)(id obj))block {
	__block BOOL contains = NO;
	[self enumerateTreeWithBlock:^(id nodeValue, id node, BOOL *stop) {
		if (block(nodeValue)) {
			contains = YES;
			*stop = YES;
		}
	}];
	return contains;
}

@end
