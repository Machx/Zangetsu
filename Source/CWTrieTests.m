//
//  CWTrieTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 4/15/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "CWTrieTests.h"
#import "CWTrie.h"

static CWTrie *trie = nil;

SpecBegin(CWTrie)

beforeAll(^{
	trie = [CWTrie new];
});

it(@"should be able to set & retrieve values for keys", ^{	
	NSString *aKey = @"Hello";
	NSString *aValue = @"World";
	[trie setObjectValue:aValue forKey:aKey];
	
	//find key that does exist
	NSString *foundValue = [trie objectValueForKey:aKey];
	expect(foundValue).to.equal(aValue);
	
	//return nil for key that doesn't exist
	expect([trie objectValueForKey:@"Foodbar"]).to.beNil();
	expect([trie objectValueForKey:nil]).to.beNil();
});

it(@"shouldn't distinguish between uppercase & lowercase if set to", ^{
	trie.caseSensitive = NO;
	[trie setObjectValue:@"Bender" forKey:@"Fry"];
	
	expect([trie objectValueForKey:@"Fry"]).to.equal(@"Bender");
	expect([trie objectValueForKey:@"FRY"]).to.equal(@"Bender");
	expect([trie objectValueForKey:@"fRy"]).to.equal(@"Bender");
});

it(@"should remove values for keys", ^{
	[trie setObjectValue:@"Bender" forKey:@"Fry"];
	
	expect([trie objectValueForKey:@"Fry"]).to.equal(@"Bender");
	
	[trie removeObjectValueForKey:@"Fry"];
	
	expect([trie objectValueForKey:@"Fry"]).to.beNil();
});

SpecEnd
