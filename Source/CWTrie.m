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

#define CWIsInvalidString(_x_) (_x_ == nil || (![_x_ isKindOfClass:[NSString class]]) || [_x_ length] == 0)

@interface CWTrieNode : NSObject
@property(nonatomic, retain) NSString *key;
@property(nonatomic, retain) id value;
@property(nonatomic, retain) NSMutableSet *children;
-(CWTrieNode *)nodeForCharacter:(NSString *)chr;
@end

@implementation CWTrieNode

@synthesize key = _key;
@synthesize value = _value;
@synthesize children = _children;

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
	if (CWIsInvalidString(aKey)) { NSLog(@"ERROR [CWTrie]: Invalid Key"); return nil; }
	
	CWTrieNode *currentNode = self.rootNode;
	const char *key = ([self caseSensitive]) ? [aKey UTF8String] : [[aKey lowercaseString] UTF8String];
	
	while (*key) {
		char *cChar = strndup(key, 1);
		NSString *aChar = [NSString stringWithUTF8String:cChar];
		free(cChar);
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
	if (CWIsInvalidString(aKey)) { NSLog(@"ERROR [CWTrie]: Key or Value was nil"); return; }
	
	CWTrieNode *currentNode = self.rootNode;
	const char *key = ([self caseSensitive]) ? [aKey UTF8String] : [[aKey lowercaseString] UTF8String];
	
	while (*key) {
		char *cChar = strndup(key, 1);
		NSString *aChar = [NSString stringWithUTF8String:(const char *)cChar];
		free(cChar);
		CWTrieNode *node = [currentNode nodeForCharacter:aChar];
		if (node) {
			currentNode = node;
		} else {
			CWTrieNode *aNode = [[CWTrieNode alloc] init];
			aNode.key = aChar;
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
