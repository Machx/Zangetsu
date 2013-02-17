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

static CWTrie *trie = nil;

SpecBegin(CWTrie)

it(@"should be able to set & retrieve values for keys", ^{
	CWTrie *aTrie = [[CWTrie alloc] init];
	
beforeAll(^{
	trie = [CWTrie new];
});

	NSString *aKey = @"Hello";
	NSString *aValue = @"World";
	[aTrie setObjectValue:aValue forKey:aKey];
	
	//find key that does exist
	NSString *foundValue = [aTrie objectValueForKey:aKey];
	expect(foundValue).to.equal(aValue);
	
	//return nil for key that doesn't exist
	expect([aTrie objectValueForKey:@"Foodbar"]).to.beNil();
	expect([aTrie objectValueForKey:nil]).to.beNil();
});

it(@"shouldn't distinguish between uppercase & lowercase if set to", ^{
	CWTrie *trie = [[CWTrie alloc] init];
	trie.caseSensitive = NO;
	[trie setObjectValue:@"Bender" forKey:@"Fry"];
	
	expect([trie objectValueForKey:@"Fry"]).to.equal(@"Bender");
	expect([trie objectValueForKey:@"FRY"]).to.equal(@"Bender");
	expect([trie objectValueForKey:@"fRy"]).to.equal(@"Bender");
});

it(@"should remove values for keys", ^{
	CWTrie *trie = [[CWTrie alloc] init];
	[trie setObjectValue:@"Bender" forKey:@"Fry"];
	
	expect([trie objectValueForKey:@"Fry"]).to.equal(@"Bender");
	
	[trie removeObjectValueForKey:@"Fry"];
	
	expect([trie objectValueForKey:@"Fry"]).to.beNil();
});

SpecEnd
