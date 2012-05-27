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
	
	tree.nodeValueEvaluator = ^NSUInteger(id object){
		if ([object respondsToSelector:@selector(intValue)]) {
			return [object intValue];
		}
		return [object hash];
	};
	
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
		NSLog(@"hit %lu",nodeValue);
	}];
	
	STAssertTrue(total == 241,nil);
}

@end
