/*
//  CWQueue.m
//  Zangetsu
//
//  Created by Colin Wheeler on 10/29/11.
//  Copyright (c) 2012. All rights reserved.
//
 
 Copyright (c) 2012 Colin Wheeler
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
 
#import "CWQueue.h"

@interface CWQueue()
//private internal ivar
@property(retain) NSMutableArray *dataStore;
@property(assign) dispatch_queue_t queue;
@end

static int64_t queueCounter = 0;

@implementation CWQueue

/**
 Note on the usage of dispatch_barrier_sync(_storageQueue, ^{ });
 these are synchronization points. Anytime a "batch operation" ie
 a method that alters more than 1 object in the queue appears then
 these are needed to ensure that all operations before that point
 complete and any ones at the end of the method ensure that all
 operations enqueued complete before going on.
 */

#pragma mark Initiailziation -

/**
 Initializes a CWQueue object with no contents
 
 Initializes & returns an empty CWQueue object ready to
 accept objects to be added to it.
 
 @return a CWQueue object ready to accept objects to be added to it.
 */
-(id)init {
	self = [super init];
	if (!self) return nil;
	
	_dataStore = [NSMutableArray array];
	const char *label = [[NSString stringWithFormat:@"com.Zangetsu.CWStack_%lli",
						  OSAtomicIncrement64(&queueCounter)] UTF8String];
	_queue = dispatch_queue_create(label, DISPATCH_QUEUE_SERIAL);
	
	return self;
}

-(id)initWithObjectsFromArray:(NSArray *)array {
	self = [super init];
	if (!self) return nil;
	
	_dataStore = [NSMutableArray arrayWithArray:array];
	const char *label = [[NSString stringWithFormat:@"com.Zangetsu.CWStack_%lli",
						  OSAtomicIncrement64(&queueCounter)] UTF8String];
	_queue = dispatch_queue_create(label, DISPATCH_QUEUE_SERIAL);
	
	return self;
}

#pragma mark Add & Remove Objects -

-(id)dequeue {
	__block id object = nil;
	dispatch_sync(self.queue, ^{
		if (self.dataStore.count == 0) return;
		object = self.dataStore[0];
		[self.dataStore removeObjectAtIndex:0];
	});
	return object;
}

-(void)enqueue:(id)object {
	if (object) {
		dispatch_sync(self.queue, ^{
			[self.dataStore addObject:object];
		});
	}
}

-(void)enqueueObjectsFromArray:(NSArray *)objects {
	if (objects.count > 0) {
		dispatch_sync(self.queue, ^{
			[self.dataStore addObjectsFromArray:objects];
		});
	}
}

-(void)removeAllObjects {
	dispatch_async(self.queue, ^{
		[self.dataStore removeAllObjects];
	});
}

#pragma mark Query Methods -

-(BOOL)containsObject:(id)object {
	__block BOOL contains = NO;
	dispatch_sync(self.queue, ^{
		contains = [self.dataStore containsObject:object];
	});
	return contains;
}

-(BOOL)containsObjectWithBlock:(BOOL (^)(id obj))block {
	__block BOOL contains = NO;
	dispatch_sync(self.queue, ^{
		NSUInteger index = [self.dataStore indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
			return block(obj);
		}];
		contains = (index != NSNotFound);
	});
	return contains;
}

-(id)peek {
	__block id object = nil;
	dispatch_sync(self.queue, ^{
		object = self.dataStore[0] ?: nil;
	});
	return object;
}

#pragma mark Enumeration Methods -

-(void)enumerateObjectsInQueue:(void(^)(id object, BOOL *stop))block {
	dispatch_sync(self.queue, ^{
		BOOL shouldStop = NO;
		for (id object in self.dataStore) {
			block(object,&shouldStop);
			if (shouldStop) return;
		}
	});
}

-(void)dequeueOueueWithBlock:(void(^)(id object, BOOL *stop))block {
	if(self.dataStore.count == 0) return;
	
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
			 withBlock:(void(^)(id object))block {
	if (![self.dataStore containsObject:targetObject]) return;
	[self dequeueOueueWithBlock:^(id object, BOOL *stop) {
		block(object);
		if ([object isEqual:targetObject]) *stop = YES;
	}];
}

#pragma mark Debug Information -

/**
 Returns an NSString with a description of the queues storage
 
 @return a NSString detailing the queues internal storage
 */
-(NSString *)description {
	__block NSString *queueDescription = nil;
	dispatch_sync(self.queue, ^{
		queueDescription = [self.dataStore description];
	});
	return queueDescription;
}

-(NSUInteger)count {
	__block NSUInteger queueCount = 0;
	dispatch_sync(self.queue, ^{
		queueCount = self.dataStore.count;
	});
	return queueCount;
}

-(BOOL)isEmpty {
	__block BOOL queueEmpty = YES;
	dispatch_sync(self.queue, ^{
		queueEmpty = (self.dataStore.count == 0);
	});
	return queueEmpty;
}

#pragma mark Comparison -

-(BOOL)isEqualToQueue:(CWQueue *)aQueue {
	__block BOOL isEqual = NO;
	dispatch_sync(self.queue, ^{
		isEqual = [self.dataStore isEqual:aQueue.dataStore];
	});
	return isEqual;
}

-(void)dealloc {
	dispatch_release(_queue);
}

@end
