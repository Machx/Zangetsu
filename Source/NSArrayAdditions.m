/*
//  NSArrayAdditions.m
//  Zangetsu
//
 	*/

#import "NSArrayAdditions.h"


@implementation NSArray (CWNSArrayAdditions)

-(id)cw_firstObject {
	return (self.count > 0 ? self[0] : nil);
}

-(void)cw_each:(void (^)(id obj, NSUInteger index, BOOL *stop))block {
	[self enumerateObjectsUsingBlock:block];
}

-(void)cw_eachConcurrentlyWithBlock:(void (^)(id obj, NSUInteger index, BOOL * stop))block {
	[self enumerateObjectsWithOptions:NSEnumerationConcurrent
						   usingBlock:block];
}

-(id)cw_findWithBlock:(BOOL (^)(id obj))block {
	NSUInteger index = [self indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
		if (block(obj)) {
			return YES;
			*stop = YES;
		}
		return NO;
	}];
	return (index != NSNotFound ? self[index] : nil);
}

-(BOOL)cw_isObjectInArrayWithBlock:(BOOL (^)(id obj))block {
	NSUInteger index = [self indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
		return (block(obj) ? YES : NO);
	}];
	return (index != NSNotFound ? YES : NO);
}

#if Z_HOST_OS_IS_MAC_OS_X

-(NSHashTable *)cw_findAllIntoWeakRefsWithBlock:(BOOL (^)(id))block {
    NSHashTable * results = [NSHashTable hashTableWithWeakObjects];
	NSIndexSet *indexes = [self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
		return block(obj);
	}];
	[indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
		[results addObject:self[idx]];
	}];
    return results;
}

#endif

-(NSArray *)cw_mapArray:(id (^)(id obj))block {
    NSMutableArray * cwArray = [NSMutableArray array];
	[self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		id rObj = block(obj);
        if (rObj) [cwArray addObject:rObj];
	}];
	return cwArray;
}

-(NSArray *)cw_arrayOfObjectsPassingTest:(BOOL (^)(id obj))block {
	NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
		return block(evaluatedObject);
	}];
	return [self filteredArrayUsingPredicate:predicate];
}

@end
