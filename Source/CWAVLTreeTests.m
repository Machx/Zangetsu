//
//  CWAVLTreeTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 8/1/12.
//
//

#import "CWAVLTreeTests.h"
#import "CWAVLTree.h"

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
}

@end
