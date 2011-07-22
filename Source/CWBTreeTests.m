//
//  CWBTreeTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 7/18/11.
//  Copyright 2011. All rights reserved.
//

#import "CWBTreeTests.h"
#import "CWBTree.h"

@implementation CWBTreeTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

-(void)testBasicTreeCreation {
    
    NSString *string1 = @"Hypnotoad";
    
    CWBTree *tree1 = [[CWBTree alloc] initWithRootNodeValue:string1];
    
    CWBTree *tree2 = [[CWBTree alloc] init];
    CWBTreeNode *node1 = [[CWBTreeNode alloc] initWithValue:string1];
    [tree2 setRootNode:node1];
    
    STAssertTrue([[[tree1 rootNode] value] isEqual:[[tree2 rootNode] value]], @"Root nodes should be equal");
}

-(void)testNodeIsEqual {
    
    NSString *string1 = @"Hypnotoad";
    
    CWBTreeNode *node1 = [[CWBTreeNode alloc] initWithValue:string1];
    
    CWBTreeNode *node2 = node1;
    
    STAssertTrue([node1 isEqualTo:node2], @"Nodes should be equivalent");
    
    CWBTreeNode *node3 = [[CWBTreeNode alloc] initWithValue:@"Cheez it!"];
    
    STAssertFalse([node1 isEqualTo:node3], @"The 2 nodes have different values and should always be false");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
