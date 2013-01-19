/*
//  NSArrayAdditions.m
//  Zangetsu
//
 	*/

#import "NSArrayAdditions.h"


@implementation NSArray (CWNSArrayAdditions)

-(id)cw_firstObject
{
	return ( [self count] > 0 ) ? [self objectAtIndex:0] : nil;
}

-(void)cw_each:(void (^)(id obj, NSUInteger index, BOOL *stop))block
{
	[self enumerateObjectsUsingBlock:block];
}

-(void)cw_eachConcurrentlyWithBlock:(void (^)(id obj, NSUInteger index, BOOL * stop))block
{
	[self enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:block];
}

-(id)cw_findWithBlock:(BOOL (^)(id obj))block
{
	__block id foundObject = nil;
	[self cw_eachConcurrentlyWithBlock:^(id object, NSUInteger index, BOOL *stop) {
		if (block(object)) {
			foundObject = object;
			*stop = YES;
		}
	}];	
    return foundObject;
}

-(BOOL)cw_isObjectInArrayWithBlock:(BOOL (^)(id obj))block
{
	return ( [self cw_findWithBlock:block] ) ? YES : NO;
}

-(NSArray *)cw_findAllWithBlock:(BOOL (^)(id obj))block
{
    NSMutableArray * results = [NSMutableArray array];
	[self cw_each:^(id obj, NSUInteger index, BOOL *stop) {
		if (block(obj)) {
			[results addObject:obj];
		}
	}];
    return results;
}

#if Z_HOST_OS_IS_MAC_OS_X

-(NSHashTable *)cw_findAllIntoWeakRefsWithBlock:(BOOL (^)(id))block
{
    NSHashTable * results = [NSHashTable hashTableWithWeakObjects];
    [self cw_each:^(id obj, NSUInteger index, BOOL *stop) {
		if (block(obj)) {
			[results addObject:obj];
		}
	}];
    return results;
}

#endif

-(NSArray *)cw_mapArray:(id (^)(id obj))block
{
    NSMutableArray * cwArray = [NSMutableArray array];
	[self cw_each:^(id obj, NSUInteger index, BOOL *stop) {
		id rObj = block(obj);
        if (rObj) {
            [cwArray addObject:rObj];
        }
	}];
    return cwArray;
}

-(NSArray *)cw_arrayOfObjectsPassingTest:(BOOL (^)(id obj))block
{
	NSMutableArray *array = [NSMutableArray array];
	[self cw_each:^(id object, NSUInteger index, BOOL *stop) {
		if (block(object)) {
			[array addObject:object];
		}
	}];
	return array;
}

@end
