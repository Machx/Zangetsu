//
//  CWBTree.m
//  Zangetsu
//
//  Created by Colin Wheeler on 7/14/11.
//  Copyright 2011. All rights reserved.
//

#import "CWBTree.h"

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
-(BOOL)isEqual:(id)object {
    if ([object isMemberOfClass:[self class]]) {
        CWBTreeNode *node = (CWBTreeNode *)object;
        
        if ([[node value] isEqualTo:[self value]] &&
            [[node leftNode] isEqualTo:[self leftNode]] &&
            [[node rightNode] isEqualTo:[self rightNode]]) {
            return YES;
        }
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

@end

@implementation CWBTree

@synthesize rootNode;

-(id)initWithRootNodeValue:(id)value
{
    self = [super init];
    if (self) {
        CWBTreeNode *node = [[CWBTreeNode alloc] initWithValue:value];
        rootNode = node;
    }
    
    return self;
}

@end
