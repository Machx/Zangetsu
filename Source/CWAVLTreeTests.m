//
//  CWAVLTreeTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 8/1/12.
//
//

#import "CWAVLTreeTests.h"
#import "CWAVLTree.h"
#import "CWFoundation.h"

@implementation CWAVLTreeTests

-(void)testBasicInsertion
{
	/**
	 Tree should look like
		 42
	   /----\
	   8    50
	 /---\
	 2   9              */
	
	CWAVLTree *tree = [[CWAVLTree alloc] init];
	
	[tree addObject:@42];
	[tree addObject:@50];
	[tree addObject:@8];
	[tree addObject:@2];
	[tree addObject:@9];
	[tree addObject:@10];
	
	[tree enumerateNodesInTreeWithBlock:^(id obj) {
		CWPrintfLine(@[obj]);
	}];
}

-(void)testObjectIsInTree
{
	CWAVLTree *tree = [[CWAVLTree alloc] init];
	
	[tree addObject:@42];
	[tree addObject:@50];
	[tree addObject:@8];
	
	STAssertTrue([tree objectIsInTree:@42], nil);
	STAssertTrue([tree objectIsInTree:@50], nil);
	STAssertTrue([tree objectIsInTree:@8], nil);
	STAssertFalse([tree objectIsInTree:@100], nil);
	STAssertFalse([tree objectIsInTree:@1], nil);
	STAssertFalse([tree objectIsInTree:@1000], nil);
}

@end
