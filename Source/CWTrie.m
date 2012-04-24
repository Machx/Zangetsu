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
@property(nonatomic, retain) NSString *key;
@property(nonatomic, retain) id value;
@property(nonatomic, retain) NSMutableSet *children;
-(CWTrieNode *)nodeForCharacter:(NSString *)chr;
@end

@implementation CWTrieNode

@synthesize key = _key;
@synthesize value = _value;
@synthesize children = _children;

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
        _children = [[NSMutableSet alloc] init];
		_value = nil;
    }
    return self;
}

-(CWTrieNode *)nodeForCharacter:(NSString *)chr
{
	NSParameterAssert(chr);
	
	NSString *aChar = ([chr length] == 1) ? chr : [chr substringToIndex:1];
	__block CWTrieNode *node = nil;
	[self.children cw_each:^(id obj, BOOL *stop) {
		CWTrieNode *aNode = (CWTrieNode *)obj;
		if ([aNode.key isEqualToString:aChar]) {
			node = aNode;
			*stop = YES;
		}
	}];
	return node;
}

-(NSString *)description
{
	NSString *debugDescription = [NSString stringWithFormat:@"CWTrieNode (\nKey: '%@'\nValue: %@\nChildren: %@\n)",
								  self.key,self.value,self.children];
	return debugDescription;
}

@end

@interface CWTrie ()
@property(nonatomic, retain) CWTrieNode *rootNode;
@end

@implementation CWTrie

@synthesize rootNode = _rootNode;
@synthesize caseSensitive = _caseSensitive;

- (id)init
{
    self = [super init];
    if (self) {
        _rootNode = [[CWTrieNode alloc] init];
		_caseSensitive = YES;
    }
    return self;
}

-(id)objectValueForKey:(NSString *)aKey
{
	NSParameterAssert(aKey);
	
	CWTrieNode *currentNode = self.rootNode;
	const char *key = ([self caseSensitive]) ? [aKey UTF8String] : [[aKey lowercaseString] UTF8String];
	
	while (*key) {
		NSString *aChar = [[NSString alloc] initWithBytes:key length:1 encoding:NSUTF8StringEncoding];
		CWTrieNode *node = [currentNode nodeForCharacter:aChar];
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
	NSParameterAssert(aKey);
	
	CWTrieNode *currentNode = self.rootNode;
	const char *key = ([self caseSensitive]) ? [aKey UTF8String] : [[aKey lowercaseString] UTF8String];
	
	while (*key) {
		NSString *aChar = [[NSString alloc] initWithBytes:key length:1 encoding:NSUTF8StringEncoding];
		CWTrieNode *node = [currentNode nodeForCharacter:aChar];
		if (node) {
			currentNode = node;
		} else {
			CWTrieNode *aNode = [[CWTrieNode alloc] initWithKey:aChar];
			[currentNode.children addObject:aNode];
			currentNode = aNode;
		}
		key++;
	}
	
	currentNode.value = aObject;
}

-(void)removeObjectValueForKey:(NSString *)aKey
{
	[self setObjectValue:nil forKey:aKey];
}

@end
