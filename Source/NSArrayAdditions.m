//
//  NSArrayAdditions.m
//  Zangetsu
//

#import "NSArrayAdditions.h"


@implementation NSArray (CWNSArrayAdditions)

/**
 Convenience Method to return the first object in
 a NSArray
 */
-(id)cw_firstObject
{
	return [(NSArray *)self objectAtIndex:0];
}

/**
 Ruby inspired iterator for NSArray in Objective-C
 */
-(NSArray *)cw_each:(void (^)(id obj))block
{
	for(id object in self){
		block(object);
	}
	
	return self;
}

/**
 Ruby Inspired Iterator for NSArray in Objective-C
 like cw_each except this one also passes in the index
 */
-(NSArray *)cw_eachWithIndex:(void (^)(id obj,NSInteger index))block
{
	NSInteger i = 0;
	
	for(id object in self){
		block(object,i);
		i++;
	}
	
	return self;
}

/**
 Simple find convenience method using blocks
 */
-(id)cw_find:(BOOL (^)(id obj))block
{
	for(id obj in self){
		if(block(obj)){
			return obj;
		}
	}
	
	return nil;
}

/**
 Like cw_find but instead of returning the first object
 that passes the test it returns all objects passing the 
 bool block test
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
 like cw_find but instead uses NSHashTable to store weak pointers to 
 all objects passing the test of the bool block
 
 I don't particularly like this name but given objc's naming 
 structure this is as good as I can do for now
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
 Simple mapping method using a block
 */
-(NSArray *)cw_mapArray:(id (^)(id obj))block
{
	NSMutableArray *cwArray = [[NSMutableArray alloc] initWithCapacity:[self count]];
	
	for(id obj in self){
		[cwArray addObject:block(obj)];
	}
	
	return cwArray;
}

@end
