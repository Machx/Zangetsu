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
