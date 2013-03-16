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

- (id)init {
    self = [super init];
    if (!self) return nil;
	
	_item = nil;
	_priority = NSUIntegerMax; //lowest priority
	
    return self;
}

+(CWPriorityQueueItem *)itemWithObject:(id)object
				  andPriority:(NSUInteger)priority {
	NSParameterAssert(object);
	CWPriorityQueueItem *queueItem = [self new];
	queueItem.item = object;
	queueItem.priority = priority;
	return queueItem;
}

-(NSString *)description {
	return [NSString stringWithFormat:@"%@: Priority: %ld Item: %@",
			NSStringFromClass([self class]), self.priority,self.item];
}

@end

@interface CWPriorityQueue ()
@property(retain) NSMutableArray *storage;
@end

@implementation CWPriorityQueue

- (id)init {
    self = [super init];
    if (!self) return nil;
	
	_storage = [NSMutableArray array];
	
    return self;
}

-(NSString *)description {
	return [NSString stringWithFormat:@"%@: %@",
			NSStringFromClass([self class]), self.storage.description];
}

-(void)_sortStorage {
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
  withPriority:(NSUInteger)priority {
	NSParameterAssert(item);
	CWPriorityQueueItem *container = [CWPriorityQueueItem itemWithObject:item
															 andPriority:priority];
	[self.storage addObject:container];
	[self _sortStorage];
}

-(void)removeAllObjects {
	[self.storage removeAllObjects];
}

-(NSUInteger)count {
	return self.storage.count;
}

-(id)peek {
	return ((CWPriorityQueueItem *)((self.storage.count > 0) ? self.storage[0] : nil)).item;
}

-(id)dequeue {
	if(self.storage.count == 0) return nil;
	id obj = ((CWPriorityQueueItem *)self.storage[0]).item;
	[self.storage removeObjectAtIndex:0];
	return obj;
}

-(NSArray *)dequeueAllObjectsOfNextPriorityLevel {
	if (self.storage.count == 0) return nil;
	NSUInteger priorityLevel = ((CWPriorityQueueItem *)self.storage[0]).priority;
	NSArray *priorityResults = [self _arrayOfAllObjectsOfPriority:priorityLevel];
	[self.storage removeObjectsInArray:priorityResults];
	//extract the items so we don't return CWPriorityQueueItems...
	NSMutableArray *results = [NSMutableArray array];
	[priorityResults enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		[results addObject:((CWPriorityQueueItem *)obj).item];
	}];
	return results;
}

-(NSArray *)_arrayOfAllObjectsOfPriority:(NSUInteger)priority {
	NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
		return (((CWPriorityQueueItem *)evaluatedObject).priority == priority);
	}];
	return [self.storage filteredArrayUsingPredicate:predicate];
}

-(NSArray *)allObjectsOfPriority:(NSUInteger)priority; {
	NSMutableArray *results = [NSMutableArray array];
	NSArray *filteredResults = [self _arrayOfAllObjectsOfPriority:priority];
	[filteredResults enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		[results addObject:((CWPriorityQueueItem *)obj).item];
	}];
	return results;
}

-(NSUInteger)countofObjectsWithPriority:(NSUInteger)priority {
	NSIndexSet *set = [self.storage indexesOfObjectsWithOptions:NSEnumerationConcurrent
													passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
		//since the array is sorted if we have gone past our priority stop
		if (((CWPriorityQueueItem *)obj).priority >  priority) *stop = YES;
		
		return (((CWPriorityQueueItem *)obj).priority == priority);
	}];
	return set.count;
}

@end
