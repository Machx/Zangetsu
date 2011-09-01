/*
//  CWTree.m
//  Zangetsu
//
//  Created by Colin Wheeler on 7/12/11.
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

-(NSUInteger)nodeLevel {
    NSUInteger level = 1;
    
    CWTreeNode *currentNode = [self parent];
    while (currentNode != nil) {
        level++;
        currentNode = [currentNode parent];
    }
    
    return level;
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
