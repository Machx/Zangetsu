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
@synthesize allowsDuplicates;

-(id)init {
    self = [super init];
    if (self) {
        value = nil;
        children = [[NSMutableArray alloc] init];
        parent = nil;
        allowsDuplicates = YES;
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
    if (self->allowsDuplicates == YES) {
        [node setParent:self];
        [[self children] addObject:node];
    }
    else {
        if (![self->children containsObject:node]) {
            __block BOOL anyNodeContainsValue = NO;
            [[self children] cw_each:^(id obj) {
                id nodeValue = [(CWTreeNode *)obj value];
                if ([nodeValue isEqualTo:[node value]]) {
                    anyNodeContainsValue = YES;
                }
            }];
            
            if (anyNodeContainsValue == NO) {
                [node setParent:self];
                [node setAllowsDuplicates:NO];
                [[self children] addObject:node];
            }
        }
    }
}

-(void)removeChild:(CWTreeNode *)node {
    if ([[self children] containsObject:node]) {
        [node setParent:nil];
        [[self children] removeObject:node];
    }
}

-(BOOL)isEqualToNode:(CWTreeNode *)node {
    if ([[node value] isEqualTo:[self value]]) {
        if ([[node parent] isEqualTo:[self parent]]) {
            if ([[node children] isEqualTo:[self children]]) {
                return YES;
            }
        }
    }
    
    return NO;
}

-(BOOL)isNodeValueEqualTo:(CWTreeNode *)node {
    if ([[node value] isEqualTo:[self value]]) {
        return YES;
    }
    
    return NO;
}

@end

@implementation CWTree

@synthesize rootNode;

-(id)initWithRootNodeValue:(id)value {
    self = [super init];
    if (self) {
        CWTreeNode *aRootNode = [[CWTreeNode alloc] initWithValue:value];
        rootNode = aRootNode;
    }
    
    return self;
}

-(BOOL)isEqualTo:(id)tree {
    if ([tree isMemberOfClass:[self class]]) {
        if ([[[self rootNode] children] isEqualTo:[[tree rootNode] children]]) {
            return YES;
        }
    }
    
    return NO;
}

@end
