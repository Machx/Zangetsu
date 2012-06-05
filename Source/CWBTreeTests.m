//
//  CWBTreeTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 4/30/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "CWBTreeTests.h"
#import "CWBTree.h"
#import "CWAssertionMacros.h"

@implementation CWBTreeTests

-(void)testBasicBTreeSetAndFind
{
	CWBTree *tree = [[CWBTree alloc] init];
	
	[tree insertValue:[NSNumber numberWithInt:30]];
	[tree insertValue:[NSNumber numberWithInt:20]];
	[tree insertValue:[NSNumber numberWithInt:50]];
	[tree insertValue:[NSNumber numberWithInt:19]];
	[tree insertValue:[NSNumber numberWithInt:25]];
	[tree insertValue:[NSNumber numberWithInt:40]];
	[tree insertValue:[NSNumber numberWithInt:57]];
	
	/*********************
	 Tree should look like
		 30
		/   \
	   20   50
	  / \   / \
	 19 25 40 57
	 *********************/
	
	__block NSUInteger total = 0;

	[tree enumerateBTreeWithBlock:^(id value, CWBTreeNode *node, BOOL *stop) {
		NSUInteger nodeValue = [(NSNumber *)value intValue];
		total += nodeValue;
	}];
	
	STAssertTrue(total == 241,nil);
}

-(void)testBTreeFind
{
	CWBTree *tree = [[CWBTree alloc] init];
	
	[tree insertValue:[NSNumber numberWithInt:30]];
	[tree insertValue:[NSNumber numberWithInt:20]];
	[tree insertValue:[NSNumber numberWithInt:50]];
	[tree insertValue:[NSNumber numberWithInt:19]];
	[tree insertValue:[NSNumber numberWithInt:25]];
	[tree insertValue:[NSNumber numberWithInt:40]];
	[tree insertValue:[NSNumber numberWithInt:57]];
	
	//Check for numbers that should be in the tree
	STAssertTrue([tree isObjectInTree:[NSNumber numberWithInt:30]],nil);
	STAssertTrue([tree isObjectInTree:[NSNumber numberWithInt:20]],nil);
	STAssertTrue([tree isObjectInTree:[NSNumber numberWithInt:50]],nil);
	STAssertTrue([tree isObjectInTree:[NSNumber numberWithInt:19]],nil);
	STAssertTrue([tree isObjectInTree:[NSNumber numberWithInt:25]],nil);
	STAssertTrue([tree isObjectInTree:[NSNumber numberWithInt:40]],nil);
	STAssertTrue([tree isObjectInTree:[NSNumber numberWithInt:57]],nil);
	
	//check for numbers that shouldn't be in the tree
	STAssertFalse([tree isObjectInTree:[NSNumber numberWithInt:44]],nil);
	STAssertFalse([tree isObjectInTree:[NSNumber numberWithInt:99]],nil);
	STAssertFalse([tree isObjectInTree:[NSNumber numberWithInt:482]],nil);
	STAssertFalse([tree isObjectInTree:[NSNumber numberWithInt:32]],nil);
	STAssertFalse([tree isObjectInTree:[NSNumber numberWithInt:4]],nil);
	STAssertFalse([tree isObjectInTree:[NSNumber numberWithInt:77]],nil);
	STAssertFalse([tree isObjectInTree:[NSNumber numberWithInt:64]],nil);
}

-(void)testEnumerationOrder
{
	CWBTree *tree = [[CWBTree alloc] init];
	
	[tree insertValue:[NSNumber numberWithInt:30]];
	[tree insertValue:[NSNumber numberWithInt:20]];
	[tree insertValue:[NSNumber numberWithInt:50]];
	[tree insertValue:[NSNumber numberWithInt:19]];
	
	__block NSMutableString *result = [[NSMutableString alloc] init];
	
	[tree enumerateBTreeInMode:CWBTreeNodeBreadthFirstSearch withBlock:^(id value, CWBTreeNode *node, BOOL *stop) {
		[result appendFormat:[value stringValue]];
	}];
	
	CWAssertEqualsStrings(result, @"30205019");
}

@end
