//
//  NSArrayAdditions.m
//  Zangetsu
//

#import "NSArrayAdditions.h"


@implementation NSArray (NSArrayAdditions)

-(id)cw_firstObject
{
	return [(NSArray *)self objectAtIndex:0];
}

-(NSArray *)cw_each:(void (^)(id obj))block
{
	for(id object in self){
		block(object);
	}
	
	return self;
}

-(NSArray *)cw_eachWithIndex:(void (^)(id obj,NSInteger index))block
{
	NSInteger i = 0;
	
	for(id object in self){
		block(object,i);
		i++;
	}
	
	return self;
}

@end
