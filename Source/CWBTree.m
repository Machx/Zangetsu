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

#import "CWBTree.h"

@interface CWBTreeNode()
@property(nonatomic, retain, readwrite) CWBTreeNode *leftNode;
@property(nonatomic, retain, readwrite) CWBTreeNode *rightNode;
@end

@implementation CWBTreeNode

@synthesize value;
@synthesize parent;
@synthesize leftNode;
@synthesize rightNode;

-(id)initWithValue:(id)aValue {
    self = [super init];
    if (self) {
        value = aValue;
        parent = nil;
        leftNode = nil;
        rightNode = nil;
    }
    
    return self;
}

/**
 checks if the node values & their left/right node pointers are equal
 */
-(BOOL)isEqualToNode:(CWBTreeNode *)node {
    if ([[node value] isEqualTo:[self value]]){
        if ([[node leftNode] isEqualTo:[self leftNode]]) {
            if ([[node rightNode] isEqualTo:[self rightNode]]) {
                return YES;
            }
        }
    }
    
    return NO;
}

-(void)assignLeftNode:(CWBTreeNode *)node {
    if (node != self) {
        if (node != nil) {
            [node setParent:self];
        }
        [self setLeftNode:node];
    }
}

-(void)assignRightNode:(CWBTreeNode *)node {
    if (node != self) {
        if (node != nil) {
            [node setParent:self];
        }
        [self setRightNode:node];
    }
}

@end

@implementation CWBTree

@synthesize rootNode;

-(id)init {
    self = [super init];
    if (self) {
        rootNode = nil;
    }
    
    return self;
}

-(id)initWithRootNodeValue:(id)value
{
    self = [super init];
    if (self) {
        CWBTreeNode *node = [[CWBTreeNode alloc] initWithValue:value];
        rootNode = node;
    }
    
    return self;
}

-(void)enumerateBTreeWithBlock:(void (^)(id nodeValue, id node, BOOL *stop))block {
    
    //1st implementation of a iterative preorder traversal...
    
    if ([self rootNode] == nil) {
        return;
    }
    
    __block BOOL shouldStop = NO;
    
    CWStack *nodes = [[CWStack alloc] init];
    [nodes push:[self rootNode]];
    
    CWBTreeNode *currentNode = nil;
    
    while (![nodes isEmpty]) {
        currentNode = [nodes pop];
        
        if ([currentNode rightNode] != nil) {
            [nodes push:[currentNode rightNode]];
        }
        if ([currentNode leftNode] != nil) {
            [nodes push:[currentNode leftNode]];
        }
        
        block([currentNode value],currentNode,&shouldStop);
        if (shouldStop == YES) {
            return;
        }
    }
}

@end
