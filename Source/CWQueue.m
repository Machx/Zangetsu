//
//  CWQueue.m
//  Zangetsu
//
//  Created by Colin Wheeler on 10/29/11.
//  Copyright (c) 2011. All rights reserved.
//

#import "CWQueue.h"

@interface CWQueue()
@property(nonatomic, retain) NSMutableArray *queue;
@end

@implementation CWQueue

@synthesize queue;

-(id)init {
	self = [super init];
	if (self) {
		queue = [[NSMutableArray alloc] init];
	}
	return self;
}

-(id)initWithObjectsFromArray:(NSArray *)array {
	self = [super init];
	if (self) {
		queue = [[NSMutableArray alloc] initWithArray:array];
	}
	return self;
}

-(id)dequeueTopObject {
	id topObject = [[self queue] cw_firstObject];
	[[self queue] removeObjectAtIndex:0];
	return topObject;
}

-(void)addObject:(id)object {
	NSParameterAssert(object);
	[[self queue] addObject:object];
}

-(void)removeAllObjects {
	[[self queue] removeAllObjects];
}

//add enumerate objects with block?

-(NSString *)description {
	return [[self queue] description];
}

-(BOOL)isEqualToQueue:(CWQueue *)aQueue {
	return [[[self queue] description] isEqualToString:[aQueue description]];
}

@end
