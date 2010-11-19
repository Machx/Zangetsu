//
//  NSArrayAdditions.m
//  Zangetsu
//

#import "NSArrayAdditions.h"


@implementation NSArray (CWNSArrayAdditions)

//
// Convenience Method to return the first object in
// a NSArray
//
-(id)cw_firstObject
{
	return [(NSArray *)self objectAtIndex:0];
}

//
// Ruby inspired iterator for NSArray in Objective-C
//
-(NSArray *)cw_each:(void (^)(id obj))block
{
	for(id object in self){
		block(object);
	}
	
	return self;
}

//
// Ruby Inspired Iterator for NSArray in Objective-C
// like cw_each except this one also passes in the index
//
-(NSArray *)cw_eachWithIndex:(void (^)(id obj,NSInteger index))block
{
	NSInteger i = 0;
	
	for(id object in self){
		block(object,i);
		i++;
	}
	
	return self;
}

//
// Simple find convenience method using blocks
//
-(id)cw_find:(BOOL (^)(id obj))block
{
	for(id obj in self){
		if(block(obj)){
			return obj;
		}
	}
	
	return nil;
}

//
// Simple mapping method using a block
//
-(NSArray *)cw_mapArray:(id (^)(id obj))block
{
	NSMutableArray *cwArray = [[NSMutableArray alloc] init];
	
	for(id obj in self){
		[cwArray addObject:block(obj)];
	}
	
	return cwArray;
}

@end
