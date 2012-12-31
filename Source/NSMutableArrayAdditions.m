/*
//  NSMutableArrayAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 8/26/11.
//  Copyright 2012. All rights reserved.
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

#import "NSMutableArrayAdditions.h"

@implementation NSMutableArray (CWNSMutableArrayAdditions)

-(void)cw_addObjectsFromArrayByCopying:(NSArray *)otherArray
{
	[otherArray cw_each:^(id obj, NSUInteger index, BOOL *stop) {
		[self addObject:[obj copy]];
	}];
}

-(void)cw_moveObject:(id)object
			 toIndex:(NSUInteger)index
{
	NSParameterAssert(object);
	NSUInteger oldIndex = [self indexOfObject:object];
	if (oldIndex == index) { return; }
	if (oldIndex != NSNotFound) {
		[self removeObjectAtIndex:oldIndex];
		[self insertObject:object atIndex:index];
		return;
	}
	CWLogErrorInfo(@"com.Zangetsu.NSMutableArrayAdditions", 404,
				   @"Object you are attempting to move was not contained in the array");
}

@end
