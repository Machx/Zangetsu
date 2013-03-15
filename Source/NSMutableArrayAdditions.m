/*
//  NSMutableArrayAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 8/26/11.
//  Copyright 2012. All rights reserved.
//
 	*/

#import "NSMutableArrayAdditions.h"

@implementation NSMutableArray (CWNSMutableArrayAdditions)

-(void)cw_addObjectsFromArrayByCopying:(NSArray *)otherArray {
	[otherArray cw_each:^(id obj, NSUInteger index, BOOL *stop) {
		[self addObject:[obj copy]];
	}];
}

-(void)cw_moveObject:(id)object
			 toIndex:(NSUInteger)index
{
	NSParameterAssert(object);
	NSUInteger oldIndex = [self indexOfObject:object];
	if (oldIndex == index) return;
	if (oldIndex != NSNotFound) {
		[self removeObjectAtIndex:oldIndex];
		[self insertObject:object atIndex:index];
		return;
	}
	CWLogErrorInfo(kCWNSMutableArrayAdditionsErrorDomain,
				   kCWNSMutableArrayAdditionsObjectNotFoundCode,
				   @"Object you are attempting to move was not contained in the array");
}

@end
