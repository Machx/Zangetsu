/*
//  CWBTreeTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 7/18/11.
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

#import "CWBTreeTests.h"
#import "CWBTree.h"

@implementation CWBTreeTests

- (void)setUp {
    [super setUp];
    
    // Set-up code here.
}

/**
 test that the CWTree objects are being created and correctly
 assigning their root nodes
 */
-(void)testBasicTreeCreation {
    
    NSString *string1 = @"Hypnotoad";
    
    CWBTree *tree1 = [[CWBTree alloc] initWithRootNodeValue:string1];
    
    CWBTree *tree2 = [[CWBTree alloc] init];
    CWBTreeNode *node1 = [[CWBTreeNode alloc] initWithValue:string1];
    tree2.rootNode = node1;
	
    STAssertTrue([[[tree1 rootNode] value] isEqual:[[tree2 rootNode] value]], @"Root nodes should be equal");
}

/**
 test for node equality
 */
-(void)testNodeIsEqual {
    
    NSString *string1 = @"Hypnotoad";
    
    CWBTreeNode *node1 = [[CWBTreeNode alloc] initWithValue:string1];
    CWBTreeNode *node2 = node1;
    
    STAssertTrue([node1 isEqualTo:node2], @"Nodes should be equivalent");
    
    CWBTreeNode *node3 = [[CWBTreeNode alloc] initWithValue:@"Cheez it!"];
    
    STAssertFalse([node1 isEqualTo:node3], @"The 2 nodes have different values and should always be false");
}

/**
 Test that we are running the iterative preorder traversal in the correct order...
 */
-(void)testEnumeration {
    
    /**
     Unit Test Example Tree Structure
     Internally CWTree uses a Stack (CWStack) object to visit all nodes...
     ---------------------
           4
           |
        /-----\
        2     5
        |
      /---\ 
      1   3
     
     //iterative preorder traversal order
     1) push node 4 onto the stack
     2) visit node 4 (popped off the stack)
     3) push 5 then 2 onto the stack
     4) visit 2 (popped off the stack)
     5) push 3 then 1 onto the stack
     6) visit 1 (popped off the stack)
     7) visit 3 (popped off the stack)
     8) visit 5 (popped off the stack)
     stack is now empty & all tree nodes traversed...
     ---------------------
     */
    
    CWBTreeNode *rNode = [[CWBTreeNode alloc] initWithValue:@"4"];
    
    CWBTreeNode *rRNode = [[CWBTreeNode alloc] initWithValue:@"5"];
	rNode.rightNode = rRNode;
    
    CWBTreeNode *rLNode = [[CWBTreeNode alloc] initWithValue:@"2"];
	rNode.leftNode = rLNode;
    
    CWBTreeNode *node2L = [[CWBTreeNode alloc] initWithValue:@"1"];
	rLNode.leftNode = node2L;
    
    CWBTreeNode *node2R = [[CWBTreeNode alloc] initWithValue:@"3"];
	rLNode.rightNode = node2R;
    
    CWBTree *tree = [[CWBTree alloc] init];
	tree.rootNode = rNode;
    
    __block NSMutableString *testString = [[NSMutableString alloc] init];
    
    [tree enumerateBTreeWithBlock:^(id nodeValue, id node, BOOL *stop) {
        [testString appendString:(NSString *)nodeValue];
    }];
    
    NSString *truthString = @"42135";
    
    STAssertTrue([testString isEqualToString:truthString], @"The Strings should be the same if the tree was traversed correctly");
}

/**
 Test that the bool pointer in the block correctly stops enumation
 */
-(void)testStopPointer {
    
    /**
     same tree structure as the testEnumeration test...
     we should visit node 4 then 2 and then stop...
     */
    
    CWBTreeNode *rNode = [[CWBTreeNode alloc] initWithValue:@"4"];
    
    CWBTreeNode *rRNode = [[CWBTreeNode alloc] initWithValue:@"5"];
	rNode.rightNode = rRNode;
    
    CWBTreeNode *rLNode = [[CWBTreeNode alloc] initWithValue:@"2"];
	rNode.leftNode = rLNode;
    
    CWBTreeNode *node2L = [[CWBTreeNode alloc] initWithValue:@"1"];
	rLNode.leftNode = node2L;
    
    CWBTreeNode *node2R = [[CWBTreeNode alloc] initWithValue:@"3"];
	rLNode.rightNode = node2R;
    
    CWBTree *tree = [[CWBTree alloc] init];
	tree.rootNode = rNode;
    
    __block NSMutableString *currentString = [[NSMutableString alloc] init];
    
    [tree enumerateBTreeWithBlock:^(id nodeValue, id node, BOOL *stop) {
        [currentString appendString:(NSString *)nodeValue];
        if ([(NSString *)nodeValue isEqualToString:@"2"]) {
            *stop = YES;
        }
    }];
    
    STAssertTrue([currentString isEqualToString:@"42"], @"the String should equal 42 if it stopped correctly");
}

-(void)testNodeLevel {
	/**
	 test the node level of nodes at various levels, nodes should report
	 that their level is 1 + N  where N is the amount of parent nodes they
	 have. 
	 */
    
    static NSString *const kTestValue = @"Now look I am not evil, my Loan officer told me so";
    
    CWBTreeNode *node1 = [[CWBTreeNode alloc] initWithValue:kTestValue];
    
    CWBTreeNode *node2 = [[CWBTreeNode alloc] initWithValue:kTestValue];
	node1.rightNode = node2;
    
    CWBTreeNode *node3 = [[CWBTreeNode alloc] initWithValue:kTestValue];
	node2.rightNode = node3;
    
    CWBTreeNode *node4 = [[CWBTreeNode alloc] initWithValue:kTestValue];
	node3.rightNode = node4;
    
    STAssertTrue([node1 nodeLevel] == 1, @"Node1 should be at Level 1");
    STAssertTrue([node2 nodeLevel] == 2, @"Node1 should be at Level 2");
    STAssertTrue([node3 nodeLevel] == 3, @"Node1 should be at Level 3");
    STAssertTrue([node4 nodeLevel] == 4, @"Node1 should be at Level 4");
}

-(void)testSetPointerToNil {
	
	CWBTreeNode *node = [[CWBTreeNode alloc] initWithValue:@"Hypnotoad"];
	STAssertNil(node.rightNode, @"Node should be nil now");
	
	CWBTreeNode *node2 = [[CWBTreeNode alloc] initWithValue:@"Nibbler"];
	[node setRightNode:node2];
	STAssertNotNil(node.rightNode, @"Node should be non nil");
	
	[node setRightNode:nil];
	STAssertNil(node.rightNode, @"Node should be nil now");
	
	[node setRightNode:node];
	STAssertNil(node.rightNode, @"Node should not allow setting itself as a child node");
}

- (void)tearDown {
    // Tear-down code here.
    
    [super tearDown];
}

@end
