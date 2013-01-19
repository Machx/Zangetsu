/*
//  CWQueue.m
//  Zangetsu
//
//  Created by Colin Wheeler on 10/29/11.
//  Copyright (c) 2012. All rights reserved.
//
 	*/
 
#import "CWQueue.h"

@interface CWQueue()
//private internal ivar
@property(retain) NSMutableArray *queue;
@property(assign) dispatch_queue_t storageQueue;
@end

@implementation CWQueue

/**
 Note on the usage of dispatch_barrier_sync(_storageQueue, ^{ });
 these are synchronization points. Anytime a "batch operation" ie
 a method that alters more than 1 object in the queue appears then
 these are needed to ensure that all operations before that point
 complete and any ones at the end of the method ensure that all
 operations enqueued complete before going on.	*/

#pragma mark Initiailziation -

/**
 Initializes a CWQueue object with no contents
 
 Initializes & returns an empty CWQueue object ready to
 accept objects to be added to it.
 
 @return a CWQueue object ready to accept objects to be added to it.	*/
-(id)init
{
	self = [super init];
	if (self) {
		_queue = [[NSMutableArray alloc] init];
		_storageQueue = dispatch_queue_create(CWUUIDCStringPrependedWithString(@"com.Zangetsu.CWQueue_"), DISPATCH_QUEUE_SERIAL);
	}
	return self;
}

-(id)initWithObjectsFromArray:(NSArray *)array
{
	self = [super init];
	if (self) {
		_queue = [[NSMutableArray alloc] initWithArray:array];
		_storageQueue = dispatch_queue_create(CWUUIDCStringPrependedWithString(@"com.Zangetsu.CWQueue_"), DISPATCH_QUEUE_SERIAL);
	}
	return self;
}

#pragma mark Add & Remove Objects -

-(id)dequeue
{
	__block id object = nil;
	dispatch_sync(self.storageQueue, ^{
		if ([self.queue count] == 0) { return; }
		object = [self.queue objectAtIndex:0]; //change back to cw_firstObject sometime
		[self.queue removeObjectAtIndex:0];
	});
	return object;
}

-(void)enqueue:(id)object
{
	if (object) {
		dispatch_sync(self.storageQueue, ^{
			[self.queue addObject:object];
		});
	}
}

-(void)enqueueObjectsFromArray:(NSArray *)objects
{
	dispatch_sync(self.storageQueue, ^{
		if (objects && ([objects count] > 0)) {
			[self.queue addObjectsFromArray:objects];
		}
	});
}

-(void)removeAllObjects
{
	dispatch_async(self.storageQueue, ^{
		[self.queue removeAllObjects];
	});
}

#pragma mark Query Methods -

-(BOOL)containsObject:(id)object
{
	__block BOOL contains = NO;
	dispatch_sync(self.storageQueue, ^{
		contains = [self.queue containsObject:object];
	});
	return contains;
}

-(BOOL)containsObjectWithBlock:(BOOL (^)(id obj))block
{
	__block BOOL contains = NO;
	dispatch_sync(self.storageQueue, ^{
		for (id obj in self.queue) {
			if (block(obj)) {
				contains = YES;
			}
		}
	});
	return contains;
}

-(id)peek
{
	__block id object = nil;
	dispatch_sync(self.storageQueue, ^{
		object = [self.queue cw_firstObject];
	});
	return object;
}

#pragma mark Enumeration Methods -

-(void)enumerateObjectsInQueue:(void(^)(id object, BOOL *stop))block
{
	dispatch_sync(self.storageQueue, ^{
		BOOL shouldStop = NO;
		for (id object in self.queue) {
			block(object,&shouldStop);
			if (shouldStop) { return; }
		}
	});
}

-(void)dequeueOueueWithBlock:(void(^)(id object, BOOL *stop))block
{	
	if([self.queue count] == 0) { return; }
	
	BOOL shouldStop = NO;
	id dequeuedObject = nil;
	
	do {
		dequeuedObject = [self dequeue];
		if(dequeuedObject){
			block(dequeuedObject,&shouldStop);
		}
	} while ((shouldStop == NO) && (dequeuedObject));
}

-(void)dequeueToObject:(id)targetObject 
			 withBlock:(void(^)(id object))block 
{
	if (![self.queue containsObject:targetObject]) {
		return;
	}
	[self dequeueOueueWithBlock:^(id object, BOOL *stop) {
		block(object);
		if ([object isEqual:targetObject]) {
			*stop = YES;
		}
	}];
}

#pragma mark Debug Information -

/**
 Returns an NSString with a description of the queues storage
 
 @return a NSString detailing the queues internal storage	*/
-(NSString *)description
{
	__block NSString *queueDescription = nil;
	dispatch_sync(self.storageQueue, ^{
		queueDescription = [self.queue description];
	});
	return queueDescription;
}

-(NSUInteger)count
{
	__block NSUInteger queueCount = 0;
	dispatch_sync(self.storageQueue, ^{
		queueCount = [self.queue count];
	});
	return queueCount;
}

-(BOOL)isEmpty
{
	__block BOOL queueEmpty = YES;
	dispatch_sync(self.storageQueue, ^{
		queueEmpty = ([self.queue count] == 0);
	});
	return queueEmpty;
}

#pragma mark Comparison -

-(BOOL)isEqualToQueue:(CWQueue *)aQueue
{
	__block BOOL isEqual;
	dispatch_sync(self.storageQueue, ^{
		isEqual = [self.queue isEqual:aQueue.queue];
	});
	return isEqual;
}

-(void)dealloc
{
	dispatch_release(_storageQueue);
}

@end
