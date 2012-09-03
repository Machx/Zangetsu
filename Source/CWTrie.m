/*
//  CWTrie.m
//  Zangetsu
//
//  Created by Colin Wheeler on 4/15/12.
//  Copyright (c) 2012. All rights reserved.
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

#import "CWTrie.h"

@interface CWTrieNode : NSObject
- (id)initWithKey:(NSString *)nodeKey;
@property(retain) NSString *key;
@property(retain) id value;
@property(retain) NSMutableSet *children;
@end

@implementation CWTrieNode

/**
 This should be the designated initializer 99.99% of the time
 */
- (id)initWithKey:(NSString *)nodeKey
{
	self = [super init];
	if (self) {
		_key = nodeKey;
		_value = nil;
		_children = [[NSMutableSet alloc] init];
	}
	return self;
}

- (id)init
{
    self = [super init];
    if (self) {
		_key = nil;
		_value = nil;
		_children = [[NSMutableSet alloc] init];
    }
    return self;
}

-(NSString *)description
{
	NSString *debugDescription = [NSString stringWithFormat:@"CWTrieNode (\nKey: '%@'\nValue: %@\nChildren: %@\n)",
								  self.key,self.value,self.children];
	return debugDescription;
}

@end

BOOL CWTrieNodeHasErrorForCharacter(NSString *character);

@interface CWTrie()
@property(retain) CWTrieNode *rootNode;
+(CWTrieNode *)nodeForCharacter:(NSString *)chr inNode:(CWTrieNode *)aNode;
@end

@implementation CWTrie

- (id)init
{
    self = [super init];
    if (self) {
        _rootNode = [[CWTrieNode alloc] init];
		_caseSensitive = YES;
    }
    return self;
}

-(NSString *)description
{
	NSString *description = [NSString stringWithFormat:@"Trie (\nCase Sensitive: %@\nNodes: %@",
							 CWBOOLString(self.caseSensitive),self.rootNode];
	return description;
}

BOOL CWTrieNodeHasErrorForCharacter(NSString *character)
{
	if (character == nil) {
		NSError *error = CWCreateError(@"com.Zagetsu.Trie", 442,
									   @"Character to be looked up is nil");
		CWLogError(error);
		return YES;
	}
	if (![character cw_isNotEmptyString]) {
		NSError *error = CWCreateError(@"com.Zangetsu.Trie", 443,
									   @"Character to be looked up is an empty string");
		CWLogError(error);
		return YES;
	}
	
	return NO;
}

+(CWTrieNode *)nodeForCharacter:(NSString *)chr 
						 inNode:(CWTrieNode *)aNode
{
	if (CWTrieNodeHasErrorForCharacter(chr)) {
		return nil;
	}
	
	NSString *aChar = ([chr length] == 1) ? chr : [chr substringToIndex:1];
	CWTrieNode *node = [aNode.children cw_findWithBlock:^BOOL(id obj) {
		CWTrieNode *lookupNode = (CWTrieNode *)obj;
		if ([lookupNode.key isEqualToString:aChar]) {
			return YES;
		}
		return NO;
	}];
	
	return node;
}

-(id)objectValueForKey:(NSString *)aKey
{
	if((!aKey) || (![aKey cw_isNotEmptyString])) {
		CWDebugLog(@"ERROR: nil or 0 length key. Returning nil");
		return nil;
	}
	
	CWTrieNode *currentNode = self.rootNode;
	const char *key = ([self caseSensitive]) ? [aKey UTF8String] : [[aKey lowercaseString] UTF8String];
	
	while (*key) {
		NSString *aChar = [[NSString alloc] initWithBytes:key length:1 encoding:NSUTF8StringEncoding];
		CWTrieNode *node = [CWTrie nodeForCharacter:aChar inNode:currentNode];
		if (node) {
			currentNode = node;
			key++;
		} else {
			return nil;
		}
	}
	
	return currentNode.value;
}

-(void)setObjectValue:(id)aObject 
			   forKey:(NSString *)aKey
{
	if((!aKey) || (![aKey cw_isNotEmptyString])) {
		CWDebugLog(@"ERROR: Key is nil, cannot set value..."); 
		return; 
	}
	
	CWTrieNode *currentNode = self.rootNode;
	const char *key = ([self caseSensitive]) ? [aKey UTF8String] : [[aKey lowercaseString] UTF8String];
	
	while (*key) {
		NSString *aChar = [[NSString alloc] initWithBytes:key length:1 encoding:NSUTF8StringEncoding];
		CWTrieNode *node = [CWTrie nodeForCharacter:aChar inNode:currentNode];
		if (node) {
			currentNode = node;
		} else {
			CWTrieNode *aNode = [[CWTrieNode alloc] initWithKey:aChar];
			[currentNode.children addObject:aNode];
			currentNode = aNode;
		}
		key++;
	}
	
	if (![currentNode isEqual:self.rootNode]) {
		currentNode.value = aObject;
	}
}

-(void)removeObjectValueForKey:(NSString *)aKey
{
	[self setObjectValue:nil forKey:aKey];
}

@end
