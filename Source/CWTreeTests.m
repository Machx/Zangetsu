/*
//  CWTreeTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 7/15/11.
//  Copyright 2012. All rights reserved.
//
 
 Copyright (c) 2012 Colin Wheeler
 
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

SpecBegin(CWTree)

describe(@"CWTree Root Node", ^{
	it(@"should correctly return the root node", ^{
		NSString *aString = @"Hello World!";
		
		CWTree *tree1 = [[CWTree alloc] init];
		CWTreeNode *node1 = [[CWTreeNode alloc] initWithValue:aString];
		[tree1 setRootNode:node1];
		
		CWTree *tree2 = [[CWTree alloc] initWithRootNodeValue:aString];
		
		expect([[tree1 rootNode] isNodeValueEqualTo:[tree2 rootNode]]).to.beTruthy();
		expect([[tree1 rootNode] isEqualToNode:[tree2 rootNode]]).to.beTruthy();
		expect([[tree1 rootNode] isEqualTo:[tree2 rootNode]]).to.beFalsy();
	});
});

describe(@"-isEqualToTree", ^{
	it(@"should correctly return when a CWTree instance is equal to another", ^{
		NSString *aStringVal = @"Hynotoad";
		CWTree *tree1 = [[CWTree alloc] initWithRootNodeValue:aStringVal];
		CWTree *tree2 = [[CWTree alloc] initWithRootNodeValue:aStringVal];
		
		expect([tree1 isEqualToTree:tree2]).to.beTruthy();
		expect([tree1 isEqualToTree:tree1]).to.beTruthy();
		
		CWTree *tree3 = nil;
		expect([tree1 isEqualToTree:tree3]).to.beFalsy();
	});
});

describe(@"-enumerateTreeWithBlock", ^{
	//TODO: move the tree creation code here?
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
	
	it(@"should enumerate nodes in the correct order", ^{
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
		
		__block NSMutableString *resultString = [[NSMutableString alloc] init];
		[tree enumerateTreeWithBlock:^(id nodeValue, id node, BOOL *stop) {
			[resultString appendString:(NSString *)nodeValue];
		}];
		
		expect(resultString).to.equal(kTreeEnumerationGoodResult);
	});

	it(@"should stop when the stop pointer is set to YES", ^{
		/**
		 make sure that the stop pointer in the block argument is respected
		 and when it is set to YES then the enumeration stops and the block
		 is not called anymore. The Tree structure in this test is exactly
		 the same as the testTreeEnumeration test but instead of enumerating
		 over all nodes we are stopping at a specific point.
		 */
		//we are going to halt enumeration when we reach the node with 3
		static NSString * const kTreeEnumerationGoodResult = @"123";
		
		__block NSMutableString *resultString = [[NSMutableString alloc] init];
		[tree enumerateTreeWithBlock:^(id nodeValue, id node, BOOL *stop) {
			[resultString appendString:(NSString *)nodeValue];
			if ([(NSString *)nodeValue isEqualToString:@"3"]) {
				*stop = YES;
			}
		}];
		
		expect(resultString).to.equal(kTreeEnumerationGoodResult);
	});
});

SpecEnd

SpecBegin(CWTreeNode)

describe(@"-addChild", ^{
	it(@"should not add duplicates if set to do so", ^{
		NSString *myString = @"hello I am your string";
		CWTreeNode *node = [[CWTreeNode alloc] initWithValue:myString];
		[node setAllowsDuplicates:NO];
		
		expect(node.children.count == 0).to.beTruthy();

		NSString *myString1 = @"Obey Hyponotoad";
		CWTreeNode *node1 = [[CWTreeNode alloc] initWithValue:myString1];
		[node addChild:node1];
		
		expect(node.children.count == 1).to.beTruthy();

		[node addChild:node1];
		
		expect(node.children.count == 1).to.beTruthy();
		
		CWTreeNode *node2 = [[CWTreeNode alloc] initWithValue:myString1];
		[node addChild:node2];
		
		expect(node.children.count == 1).to.beTruthy();
	});
});

describe(@"-nodeLevel", ^{
	it(@"should return the correct node level", ^{
		CWTreeNode *node1 = [[CWTreeNode alloc] initWithValue:@"hello"];
		
		expect(node1.nodeLevel == 1).to.beTruthy();

		CWTreeNode *node2 = [[CWTreeNode alloc] initWithValue:@"world"];
		[node1 addChild:node2];
		
		expect(node2.nodeLevel == 2).to.beTruthy();
	});
});

SpecEnd
