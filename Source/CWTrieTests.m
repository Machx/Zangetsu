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
	
	[aTrie setObjectValue:aValue forKey:aKey];
	
	//find key that does exist
	NSString *foundValue = [aTrie objectValueForKey:aKey];
	CWAssertEqualsStrings(aValue, foundValue);
	
	//return nil for key that doesn't exist
	STAssertNil([aTrie objectValueForKey:@"Foobar"],@"key doesn't exist in this trie");
}

@end
