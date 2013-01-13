//
//  CWPriorityQueue.m
//  ObjC_Playground
//
//  Created by Colin Wheeler on 12/18/12.
//  Copyright (c) 2012 Colin Wheeler. All rights reserved.
//

#import "CWPriorityQueue.h"

@interface CWPriorityQueueItem : NSObject
@property(retain) id item;
@property(assign) NSUInteger priority;
@end

@implementation CWPriorityQueueItem

- (id)init
{
    self = [super init];
    if (self) {
        _item = nil;
		_priority = NSUIntegerMax; //lowest priority
    }
    return self;
}

+(instancetype)itemWithObject:(id)object
				  andPriority:(NSUInteger)priority
{
	NSParameterAssert(object);
	CWPriorityQueueItem *queueItem = [self new];
	queueItem.item = object;
	queueItem.priority = priority;
	return queueItem;
}

-(NSString *)description
{
	return [NSString stringWithFormat:@"%@: Priority: %ld Item: %@",
			NSStringFromClass([self class]), _priority,_item];
}

@end

@interface CWPriorityQueue ()
@property(retain) NSMutableArray *storage;
@end

@implementation CWPriorityQueue

- (id)init
{
    self = [super init];
    if (self) {
        _storage = [NSMutableArray array];
    }
    return self;
}

-(NSString *)description {
	return [NSString stringWithFormat:@"%@: %@",
			NSStringFromClass([self class]), self.storage.description];
}

-(void)_sortStorage
{
	[self.storage sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
		NSUInteger obj1Priority = ((CWPriorityQueueItem *)obj1).priority;
		NSUInteger obj2Priority = ((CWPriorityQueueItem *)obj2).priority;
		if (obj1Priority < obj2Priority) {
			return NSOrderedAscending;
		} else if (obj1Priority == obj2Priority) {
			return NSOrderedSame;
		} else {
			return NSOrderedDescending;
		}
	}];
}

-(void)addItem:(id)item
  withPriority:(NSUInteger)priority
{
	NSParameterAssert(item);
	CWPriorityQueueItem *container = [CWPriorityQueueItem itemWithObject:item
															 andPriority:priority];
	[self.storage addObject:container];
	[self _sortStorage];
}

-(id)dequeue
{
	if(self.storage.count == 0) { return nil; }
	id obj = ((CWPriorityQueueItem *)self.storage[0]).item;
	[self.storage removeObjectAtIndex:0];
	return obj;
}

-(NSArray *)_arrayOfAllObjectsOfPriority:(NSUInteger)priority
{
	NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
		return (((CWPriorityQueueItem *)evaluatedObject).priority == priority);
	}];
	return [self.storage filteredArrayUsingPredicate:predicate];
}

-(NSSet *)allObjectsOfPriority:(NSUInteger)priority;
{
	NSMutableSet *results = [NSMutableSet set];
	NSArray *filteredResults = [self _arrayOfAllObjectsOfPriority:priority];
	[filteredResults cw_each:^(id object, NSUInteger index, BOOL *stop) {
		CWPriorityQueueItem *queueItem = (CWPriorityQueueItem *)object;
		[results addObject:queueItem.item];
	}];
	return results;
}

-(NSUInteger)countofObjectsWithPriority:(NSUInteger)priority
{
	__block int32_t count = 0;
	[self.storage cw_eachConcurrentlyWithBlock:^(id object, NSUInteger index, BOOL *stop) {
		//since the array is sorted if we have gone past our priority stop
		if (((CWPriorityQueueItem *)object).priority >  priority) *stop = YES;
		//otherwise if the priority matches then increment count
		if (((CWPriorityQueueItem *)object).priority == priority) {
			OSAtomicIncrement32(&count);
		}
	}];
	return (NSUInteger)count;
}

@end
