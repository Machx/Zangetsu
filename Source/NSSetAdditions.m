//
//  NSSetAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/15/10.
//  Copyright 2010. All rights reserved.
//

#import "NSSetAdditions.h"


@implementation NSSet (CWNSSetAdditions)

/**
 Ruby inspired iterator
 */
-(NSSet *)cw_each:(void (^)(id obj))block
{
	for (id obj in self) {
		block(obj);
	}
	
	return self;
}

/**
 Simple convenience method to find a object in
 a NSSet using a block
 */
-(id)cw_findWithBlock:(BOOL (^)(id obj))block
{
	for(id obj in self){
		if(block(obj)){
			return obj;
		}
	}
	
	return nil;
}

/**
 like cw_find but instead uses NSArray to store 
 all objects passing the test of the bool block
 */
-(NSArray *)cw_findAllWithBlock:(BOOL (^)(id obj))block
{
	NSMutableArray *results = [[NSMutableArray alloc] init];
	
	for (id obj in self) {
		if (block(obj)) {
			[results addObject:obj];
		}
	}
	
	if (results.count != 0) {
		return results;
	}
	
	return nil;
}

/**
 experimental method
 like cw_find but instead uses NSHashTable to store pointers to 
 all objects passing the test of the bool block
 */
-(NSHashTable *)cw_findAllIntoWeakRefsWithBlock:(BOOL (^)(id))block
{
	NSHashTable *results = [NSHashTable hashTableWithWeakObjects];
	
	for (id obj in self) {
		if (block(obj)) {
			[results addObject:obj];
		}
	}

	if (results.count != 0) {
		return results;
	}

	return nil;
}

/**
 Convenient Map method for NSSet
 */
-(NSSet *)cw_mapSet:(id (^)(id obj))block
{
	NSMutableSet *cwSet = [[NSMutableSet alloc] initWithCapacity:[self count]];
	
	for(id obj in self){
		[cwSet addObject:block(obj)];
	}
	
	return cwSet;
}

@end
