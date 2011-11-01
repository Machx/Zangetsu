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

//MARK: -
//MARK: Initiailziation

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

//MARK: -
//MARK: Add & Remove Objects

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

-(void)enumerateObjectsInQueue:(void(^)(id object))block {
	for (id object in [self queue]) {
		block(object);
	}
}

//MARK: -
//MARK: Debug Information

-(NSString *)description {
	return [[self queue] description];
}

-(NSUInteger)count {
	return [[self queue] count];
}

//MARK: -
//MARK: Comparison

-(BOOL)isEqualToQueue:(CWQueue *)aQueue {
	return [[[self queue] description] isEqualToString:[aQueue description]];
}

@end
