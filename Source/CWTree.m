//
//  CWTree.m
//  Zangetsu
//
//  Created by Colin Wheeler on 7/12/11.
//  Copyright 2011. All rights reserved.
//

#import "CWTree.h"

@interface CWTreeNode()
@property(nonatomic, readwrite, retain) NSMutableArray *children;
@end

@implementation CWTreeNode

@synthesize value;
@synthesize children;
@synthesize parent;

-(id)init {
    self = [super init];
    if (self) {
        value = nil;
        children = [[NSMutableArray alloc] init];
        parent = nil;
    }
    
    return self;
}

-(id)initWithValue:(id)aValue {
    self = [super init];
    if (self) {
        value = aValue;
        children = [[NSMutableArray alloc] init];
        parent = nil;
    }
    
    return self;
}

-(void)addChild:(CWTreeNode *)node {
    [node setParent:self];
    [[self children] addObject:node];
}

-(void)removeChild:(CWTreeNode *)node {
    if ([[self children] containsObject:node]) {
        [node setParent:nil];
        [[self children] removeObject:node];
    }
}

@end
