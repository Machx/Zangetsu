/*
//  NSSetAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/15/10.
//  Copyright 2010. All rights reserved.
//
 	*/

#import "NSSetAdditions.h"


@implementation NSSet (CWNSSetAdditions)

-(void)cw_each:(void (^)(id obj, BOOL *stop))block {
	[self enumerateObjectsUsingBlock:block];
}

-(void)cw_eachConcurrentlyWithBlock:(void (^)(id obj,BOOL *stop))block {
	[self enumerateObjectsWithOptions:NSEnumerationConcurrent
						   usingBlock:block];
}

-(id)cw_findWithBlock:(BOOL (^)(id obj))block {
	for(id obj in self){
		if(block(obj)) return obj;
	}
	return nil;
}

-(BOOL)cw_isObjectInSetWithBlock:(BOOL (^)(id obj))block {
	return ([self cw_findWithBlock:block] ? YES : NO);
}

#if Z_HOST_OS_IS_MAC_OS_X
-(NSHashTable *)cw_findAllIntoWeakRefsWithBlock:(BOOL (^)(id))block {
	NSHashTable *results = [NSHashTable hashTableWithWeakObjects];
	[self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
		if (block(obj)) [results addObject:obj];
	}];
	return results;
}
#endif

-(NSSet *)cw_mapSet:(id (^)(id obj))block {
	NSMutableSet *mappedSet = [NSMutableSet set];
	[self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
		id rObj = block(obj);
		if (rObj) [mappedSet addObject:rObj];
	}];
    return mappedSet;
}

@end
