//
//  CWBTree.m
//  Zangetsu
//
//  Created by Colin Wheeler on 7/14/11.
//  Copyright 2011. All rights reserved.
//

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
    if ([[node value] isEqualTo:[self value]] &&
        [[node leftNode] isEqualTo:[self leftNode]] &&
        [[node rightNode] isEqualTo:[self rightNode]]) {
        return YES;
    }
    
    return NO;
}

/**
 checks if the node values are equal
 */
-(BOOL)isEqualTo:(id)object {
    if ([object isMemberOfClass:[self class]]) {
        if ([[(CWBTreeNode *)object value] isEqualTo:[self value]]) {
            return YES;
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
