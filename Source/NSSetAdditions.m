//
//  NSSetAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/15/10.
//  Copyright 2010. All rights reserved.
//

#import "NSSetAdditions.h"


@implementation NSSet (CWNSSetAdditions)

//
// Simple convenience method to find a object in
// a NSSet using a block
//
-(id)cw_find:(BOOL (^)(id obj))block
{
	for(id obj in self){
		if(block(obj)){
			return obj;
		}
	}
	
	return self;
}

-(NSSet *)cw_map:(id (^)(id obj))block
{
	NSMutableSet *cwSet = [[NSMutableSet alloc] init];
	
	for(id obj in self){
		[cwSet addObject:block(obj)];
	}
	
	return cwSet;
}

@end
