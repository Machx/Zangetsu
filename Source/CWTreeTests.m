/*
//  CWTreeTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 7/15/11.
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

#import "CWTreeTests.h"
#import "CWTree.h"
#import "CWAssertionMacros.h"

@implementation CWTreeTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

-(void)testCWTreeRootNode
{
    
    NSString *aString = [[NSString alloc] initWithString:@"Hello World!"];
    
    CWTree *tree1 = [[CWTree alloc] init];
    CWTreeNode *node1 = [[CWTreeNode alloc] initWithValue:aString];
    [tree1 setRootNode:node1];
    
    CWTree *tree2 = [[CWTree alloc] initWithRootNodeValue:aString];
    
    STAssertTrue([[tree1 rootNode] isNodeValueEqualTo:[tree2 rootNode]], @"Nodes should be equal");
    
    STAssertFalse([[tree1 rootNode] isEqualTo:[tree2 rootNode]], @"The Root nodes should not be equal because they are in different trees");
}

-(void)testTreeEquality
{
    
    NSString *aStringVal = [[NSString alloc] initWithString:@"Hynotoad"];
    
    CWTree *tree1 = [[CWTree alloc] initWithRootNodeValue:aStringVal];
    CWTree *tree2 = [[CWTree alloc] initWithRootNodeValue:aStringVal];
    
    STAssertTrue([tree1 isEqualToTree:tree2], @"Trees should be equal");
    
    CWTreeNode *node2 = [[CWTreeNode alloc] initWithValue:@"Cheez it!"];
    [[tree1 rootNode] addChild:node2];
    
    STAssertFalse([tree1 isEqualTo:tree2], @"Trees should not be equal now");
}

-(void)testTreeNodeDoesNotAddDupes
{
    
    NSString *myString = @"hello I am your string";
    
    CWTreeNode *node = [[CWTreeNode alloc] initWithValue:myString];
    [node setAllowsDuplicates:NO];
    
    STAssertTrue([[node children] count] == 0, @"Node should't have any children");
    
    NSString *myString1 = @"Obey Hyponotoad";
    
    CWTreeNode *node1 = [[CWTreeNode alloc] initWithValue:myString1];
    
    [node addChild:node1];
    
    STAssertTrue([[node children] count] == 1, @"node should only have 1 child");
    
    [node addChild:node1];
    
    STAssertTrue([[node children] count] == 1, @"node should not have added the node again");
    
    CWTreeNode *node2 = [[CWTreeNode alloc] initWithValue:myString1];
    [node addChild:node2];
    
    STAssertTrue([[node children] count] == 1, @"node should not have added the node again");
}

-(void)testNodeLevel 
{
    
    CWTreeNode *node1 = [[CWTreeNode alloc] initWithValue:@"hello"];
    
    STAssertTrue([node1 nodeLevel] == 1, @"Node is the only object in a graph so its level should be 1");
    
    CWTreeNode *node2 = [[CWTreeNode alloc] initWithValue:@"world"];
    [node1 addChild:node2];
    
    STAssertTrue([node2 nodeLevel] == 2, @"node2 was added to 1 so its level should be 2");
}

-(void)testTreeEnumeration 
{
	static NSString * const kTreeEnumerationGoodResult = @"123456";
	
	/**
	 enumerate tree on a level by level basis. The Tree should look like...
	           1
		   ----|----
	       2       3
		 --|--     |
	     4   5     6
	 
	 The enumeration should proceed by visiting all the nodes on a level then
	 proceed down to the nodes on the next node level. The enumation starts by 
	 visiting the root node in the Tree and then (if stop isn't set to YES) proceeds
	 to that nodes children. The nodes are all placed on a queue internally and 
	 processed in the order they are visited which should be on level by level 
	 basis and from left to right on each level.
	 */
	
	CWTree *tree = [[CWTree alloc] initWithRootNodeValue:@"1"];
	
	CWTreeNode *node2 = [[CWTreeNode alloc] initWithValue:@"2"];
	[[tree rootNode] addChild:node2];
	CWTreeNode *node3 = [[CWTreeNode alloc] initWithValue:@"3"];
	[[tree rootNode] addChild:node3];
	
	CWTreeNode *node4 = [[CWTreeNode alloc] initWithValue:@"4"];
	[node2 addChild:node4];
	CWTreeNode *node5 = [[CWTreeNode alloc] initWithValue:@"5"];
	[node2 addChild:node5];
	
	CWTreeNode *node6 = [[CWTreeNode alloc] initWithValue:@"6"];
	[node3 addChild:node6];
	
	__block NSMutableString *resultString = [[NSMutableString alloc] init];
	
	[tree enumerateTreeWithBlock:^(id nodeValue, id node, BOOL *stop) {
		[resultString appendString:(NSString *)nodeValue];
	}];
	
	CWAssertEqualsStrings(resultString, kTreeEnumerationGoodResult);
}

-(void)testStopArgument
{
	/**
	 make sure that the stop pointer in the block argument is respected
	 and when it is set to YES then the enumeration stops and the block
	 is not called anymore. The Tree structure in this test is exactly 
	 the same as the testTreeEnumeration test but instead of enumerating
	 over all nodes we are stopping at a specific point.
	 */
	
	//we are going to halt enumeration when we reach the node with 3
	static NSString * const kTreeEnumerationGoodResult = @"123";
	
	CWTree *tree = [[CWTree alloc] initWithRootNodeValue:@"1"];
	
	CWTreeNode *node2 = [[CWTreeNode alloc] initWithValue:@"2"];
	[[tree rootNode] addChild:node2];
	CWTreeNode *node3 = [[CWTreeNode alloc] initWithValue:@"3"];
	[[tree rootNode] addChild:node3];
	
	CWTreeNode *node4 = [[CWTreeNode alloc] initWithValue:@"4"];
	[node2 addChild:node4];
	CWTreeNode *node5 = [[CWTreeNode alloc] initWithValue:@"5"];
	[node2 addChild:node5];
	
	CWTreeNode *node6 = [[CWTreeNode alloc] initWithValue:@"6"];
	[node3 addChild:node6];
	
	__block NSMutableString *resultString = [[NSMutableString alloc] init];
	
	[tree enumerateTreeWithBlock:^(id nodeValue, id node, BOOL *stop) {
		[resultString appendString:(NSString *)nodeValue];
		if ([(NSString *)nodeValue isEqualToString:@"3"]) {
			*stop = YES;
		}
	}];
	
	CWAssertEqualsStrings(kTreeEnumerationGoodResult, resultString);
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
