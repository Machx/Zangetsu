//
//  CWTrieTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 4/15/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "CWTrieTests.h"
#import "CWTrie.h"
#import "CWAssertionMacros.h"

@implementation CWTrieTests

-(void)testBasicSetAndFind
{
	CWTrie *aTrie = [[CWTrie alloc] init];
	
	NSString *aKey = @"Hello";
	NSString *aValue = @"World";
	
	[aTrie setObject:aValue withkey:aKey];
	
	NSString *foundValue = [aTrie findObjectWithKey:aKey];
	
	CWAssertEqualsStrings(aValue, foundValue);
}

@end
