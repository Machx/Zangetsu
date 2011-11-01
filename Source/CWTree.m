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

/**
 Initializes and creates a new CWTreenode Object
 
 @return a CWTreeNode object with no value
 */
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

/**
 Initializes and create a new CWTreeNode Object initialized with aValue
 
 This is the prefeered initializer for CWTreeNode.
 
 @param aValue an Objective-C object that the CWTreeNode will retain
 @return a new CWTreeNode with aValue for the nodes data value and no children
 */
-(id)initWithValue:(id)aValue {
    self = [super init];
    if (self) {
        value = aValue;
        children = [[NSMutableArray alloc] init];
        parent = nil;
    }
    
    return self;
}

/**
 Returns a NSString with the description of the receiving CWTreeNode Object
 
 @return a NSString with debug information on the receiving CWTreeNode Object
 */
-(NSString *)description {
	NSString *allowsDupes = CWBOOLString(self->allowsDuplicates);
	NSString *desc = [NSString stringWithFormat:@"%@ Node\nValue: %@\nParent: %@\nChildren: %@\nAllows Duplicates: %@",
					  NSStringFromClass([self class]),
					  [self->value description],
					  [self->parent description],
					  [self->children description],
					  allowsDupes];
	
	return desc;
}

/**
 Adds node to the receivers children
 
 If the receiver allows duplicates it simply adds node to the receivers children
 and sets itself as the nodes parent. If the receiver does not allow duplicates then
 the receiver checks if the node isn't already in its children. If it is not then it
 checks the node values of its children to make sure there isn't already a node with 
 the same value there if there isn't then it proceeds and adds the node to the receivers
 chilren and sets itself as the nodes parent.
 
 @param node a CWTreeNode object
 */
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

/**
 Removes the object from the receivers children
 
 The receiver checks to make sure the node is in its children and if node is,
 then it removes itself as a parent and removes the node from its chilren.
 
 @param a CWTreeNode object
 */
-(void)removeChild:(CWTreeNode *)node {
    if ([[self children] containsObject:node]) {
        [node setParent:nil];
        [[self children] removeObject:node];
    }
}

/**
 Returns a bool value if the receivers value & node pointers are all equal to node
 
 Returns a BOOL value if nodes value is equal to the receivers and if its parent poiners
 are equal as well as its children contents. 
 
 @param node a valid CWTreeNode object
 @return a BOOL indicatign if the value and children/parent pointers all equal to nodes value & pointers
 */
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

/**
 Returns a bool value indicating if nodes value is equal to the receivers
 
 @param node a valid CWTreeNode object
 @return a BOOL with yes if the node values are equal, otherwise no.
 */
-(BOOL)isNodeValueEqualTo:(CWTreeNode *)node {
    if ([[node value] isEqualTo:[self value]]) {
        return YES;
    }
    
    return NO;
}

/**
 Returns the depth level of the node in the tree it is in
 
 @return a NSUInteger with the depth level of the node in its graph of nodes
 */
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

/**
 Initializes and returns a new CWTree object with a root CWTreeNode value containing value
 
 @param value any valid Objective-C object to initialize a CWTreeNode node with
 @return a CWTree object with its rootnode pointer pointing at a newly created CWTreeNode object with value as its node value
 */
-(id)initWithRootNodeValue:(id)value {
    self = [super init];
    if (self) {
        CWTreeNode *aRootNode = [[CWTreeNode alloc] initWithValue:value];
        rootNode = aRootNode;
    }
    
    return self;
}

/**
 Returns a bool indicating if the tree object is equal to the receiver tree object
 
 @return a BOOL if the receivers children objects are equal to tree's children objects
 */
-(BOOL)isEqualTo:(id)tree {
    if ([tree isMemberOfClass:[self class]]) {
        if ([[[self rootNode] children] isEqualTo:[[tree rootNode] children]]) {
            return YES;
        }
    }
    
    return NO;
}

-(void)enumerateTreeWithBlock:(void (^)(id nodeValue, id node, BOOL *stop))block {
	if ([self rootNode] == nil) { return; }
	
	CWQueue *queue = [[CWQueue alloc] init];
	__block BOOL shouldStop = NO;
	
	[queue addObject:[self rootNode]];
	
	while ([queue count] != 0) {
		CWTreeNode *node = (CWTreeNode *)[queue dequeueTopObject];
		
		block([node value],node,&shouldStop);
		
		if (shouldStop == YES) { break; }
		
		if ([[node children] count] > 0) {
			for (CWTreeNode *childNode in [node children]) {
				[queue addObject:childNode];
			}
		}
	}
}

@end
