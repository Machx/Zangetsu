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
	NSString *aChar = [chr substringToIndex:1];
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

- (id)init
{
    self = [super init];
    if (self) {
        _rootNode = [[CWTrieNode alloc] init];
    }
    return self;
}

-(id)findObjectWithKey:(NSString *)aKey
{
	if(![aKey cw_isNotEmptyString]) { return nil; }
	
	NSUInteger index = 0;
	NSUInteger length = [aKey length];
	CWTrieNode *currentNode = self.rootNode;
	
	while (index < length) {
		NSString *aChar = [aKey substringWithRange:NSMakeRange(index, 1)];
		CWTrieNode *node = [currentNode nodeForCharacter:aChar];
		if (node) {
			currentNode = node;
		} else {
			return nil;
		}
		index++;
	}
	
	return currentNode.value;
}

-(void)setObject:(id)aObject 
		 withkey:(NSString *)aKey
{
	NSUInteger index = 0;
	NSUInteger length = [aKey length];
	CWTrieNode *currentNode = self.rootNode;
	
	while (index < length) {
		NSString *aChar = [aKey substringWithRange:NSMakeRange(index, 1)];
		CWTrieNode *node = [currentNode nodeForCharacter:aChar];
		if (node) {
			currentNode = node;
		} else {
			CWTrieNode *aNode = [[CWTrieNode alloc] init];
			aNode.key = aChar;
			[currentNode.children addObject:aNode];
			currentNode = aNode;
		}
		index++;
	}
	
	currentNode.value = aObject;
}

@end
