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

-(void)cw_each:(void (^)(id obj, BOOL *stop))block 
{	
	[self enumerateObjectsUsingBlock:block];
}

-(void)cw_eachConcurrentlyWithBlock:(void (^)(id obj,BOOL *stop))block 
{	
	dispatch_group_t group = dispatch_group_create();
	const char *label = CWUUIDCStringPrependedWithString(@"com.Zangetsu.NSSetAdditions_ConncurrentEach_");
	dispatch_queue_t queue = dispatch_queue_create(label, DISPATCH_QUEUE_CONCURRENT);
	__block BOOL _stop = NO;

	for(id object in self){

		dispatch_group_async(group, queue, ^{
			block(object,&_stop);
		});
		
		if (_stop) { break; }
	}

	dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
	dispatch_release(group);
	dispatch_release(queue);
}

-(id)cw_findWithBlock:(BOOL (^)(id obj))block
{
	for(id obj in self){
		if(block(obj)){
			return obj;
		}
	}
	return nil;
}

-(NSSet *)cw_findAllWithBlock:(BOOL (^)(id obj))block
{
	NSMutableSet *results = [[NSMutableSet alloc] init];
	[self cw_each:^(id obj, BOOL *stop) {
		if (block(obj)) {
			[results addObject:obj];
		}
	}];
	return results;
}

-(BOOL)cw_isObjectInSetWithBlock:(BOOL (^)(id obj))block
{
	id obj = nil;
	obj = [self cw_findWithBlock:block];
	return (obj) ? YES : NO;
}

#if Z_HOST_OS_IS_MAC_OS_X
-(NSHashTable *)cw_findAllIntoWeakRefsWithBlock:(BOOL (^)(id))block
{
	NSHashTable *results = [NSHashTable hashTableWithWeakObjects];
	[self cw_each:^(id obj, BOOL *stop) {
		if (block(obj)) {
			[results addObject:obj];
		}
	}];
	return results;
}
#endif

-(NSSet *)cw_mapSet:(id (^)(id obj))block
{
	NSMutableSet *mappedSet = [[NSMutableSet alloc] init];
	[self cw_each:^(id obj, BOOL *stop) {
		id rObj = block(obj);
		if (rObj) {
			[mappedSet addObject:rObj];
		}
	}];
    return mappedSet;
}

@end
