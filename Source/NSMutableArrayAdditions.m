/*
//  NSMutableArrayAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 8/26/11.
//  Copyright 2012. All rights reserved.
//
 
 Copyright (c) 2013, Colin Wheeler
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 - Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "NSMutableArrayAdditions.h"

@implementation NSMutableArray (CWNSMutableArrayAdditions)

-(void)cw_addObjectsFromArrayByCopying:(NSArray *)otherArray {
	for (id object in otherArray) {
		[self addObject:[object copy]];
	}
}

-(void)cw_moveObject:(id)object
			 toIndex:(NSUInteger)index
{
	CWAssert(object != nil);
	CWAssert(index <= (self.count - 1));
	NSUInteger oldIndex = [self indexOfObject:object];
	if (oldIndex == index) return;
	if (oldIndex != NSNotFound) {
		[self removeObjectAtIndex:oldIndex];
		[self insertObject:object atIndex:index];
		return;
	}
	NSLog(@"%s: Object you are attempting to move was not contained in the array",__PRETTY_FUNCTION__);
}

@end
