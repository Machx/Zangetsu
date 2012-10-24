/*
//  CWFixedQueue.m
//  Zangetsu
//
//  Created by Colin Wheeler on 9/10/12.
//
//
 
 */

#import "CWFixedQueue.h"

@interface CWFixedQueue()
@property(retain) NSMutableArray *storage;
-(void)clearExcessObjects;
@end

@implementation CWFixedQueue

-(id)initWithCapacity:(NSUInteger)capacity
{
	self = [super init];
	if (self) {
		_storage = [NSMutableArray new];
		_capacity = capacity;
		_evictionBlock = nil;
	}
	return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        _storage = [NSMutableArray new];
		_capacity = 50;
		_evictionBlock = nil;
    }
    return self;
}

-(NSUInteger)count
{
	return [self.storage count];
}

-(id)objectAtIndexedSubscript:(NSUInteger)index
{
	return [self.storage objectAtIndexedSubscript:index];
}

-(void)setObject:(id)object atIndexedSubscript:(NSUInteger)idx
{
	[self.storage setObject:object atIndexedSubscript:idx];
}

-(void)enqueue:(id)object
{
	if (object && ![self.storage containsObject:object]) {
		[self.storage addObject:object];
		[self clearExcessObjects];
	} else if(object) {
		NSUInteger objectIndex = [self.storage indexOfObject:object];
		[self.storage removeObjectAtIndex:objectIndex];
		[self.storage addObject:object];
	}
}

-(void)enqueueObjectsInArray:(NSArray *)array
{
	if (array && ([array count] > 0)) {
		[self.storage addObjectsFromArray:array];
		[self clearExcessObjects];
	}
}

-(void)clearExcessObjects
{
	while ([self.storage count] > self.capacity) {
		if (self.evictionBlock) {
			self.evictionBlock(self.storage[0]);
		}
		[self.storage removeObjectAtIndex:0];
	}
}

-(id)dequeue
{
	if ([self.storage count] > 0) {
		id dequeuedObject = [self.storage objectAtIndex:0];
		[self.storage removeObjectAtIndex:0];
		return dequeuedObject;
	}
	return nil;
}

-(void)enumerateContents:(void (^)(id object, NSUInteger index, BOOL *stop))block
{
	[self.storage enumerateObjectsUsingBlock:block];
}

-(void)enumerateContentsWithOptions:(NSEnumerationOptions)options
						 usingBlock:(void (^)(id object, NSUInteger index, BOOL *stop))block
{
	[self.storage enumerateObjectsWithOptions:options usingBlock:block];
}

@end
