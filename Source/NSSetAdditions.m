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
 Experimental each method that runs concurrently
 */
-(NSSet *)cw_eachConcurrentlyWithBlock:(void (^)(id obj,BOOL *stop))block
{
	dispatch_group_t group = dispatch_group_create();
	
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

	__block BOOL _stop = NO;

	for(id object in self){

		if (_stop == YES) { break; }

		dispatch_group_async(group, queue, ^{
			block(object,&_stop);
		});
	}

	dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
	dispatch_release(group);

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
 Exactly like cw_findWithBlock except it returns a BOOL
 */
-(BOOL)cw_isObjectInSetWithBlock:(BOOL (^)(id obj))block
{
	for (id obj in self) {
		if (block(obj)) {
			return YES;
		}
	}
	
	return NO;
}

/**
 like cw_find but instead uses NSArray to store 
 all objects passing the test of the bool block
 */
-(NSSet *)cw_findAllWithBlock:(BOOL (^)(id obj))block
{
	NSMutableSet *results = [[NSMutableSet alloc] init];
	
	for (id obj in self) {
		if (block(obj)) {
			[results addObject:obj];
		}
	}
	
	return results;
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

	return results;
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

/**
 selectivelyMapSet basically maps a set by enumerating
 over the set to be mapped and executes the block while
 passing in the object to map. You simply need to either
 (1) return the object to be mapped in the new set or
 (2) return nil if you don't want to map the passed in object
 */
-(NSSet *)cw_selectivelyMapSet:(id (^)(id obj))block
{
    NSMutableSet *cwArray = [[NSMutableSet alloc] init];

    for (id obj in self) {
        id rObj = block(obj);
        if(rObj){
            [cwArray addObject:rObj];
        }
    }

    return cwArray;
}

@end
