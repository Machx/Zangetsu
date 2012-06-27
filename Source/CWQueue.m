/*
//  CWQueue.m
//  Zangetsu
//
//  Created by Colin Wheeler on 10/29/11.
//  Copyright (c) 2011. All rights reserved.
//
 
 Copyright (c) 2011 Colin Wheeler
 
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
@property(nonatomic, retain) NSMutableArray *queue;
@property(nonatomic, assign) dispatch_queue_t storageQueue;
@property(nonatomic, assign) dispatch_queue_t batchQueue;
@end

@implementation CWQueue

@synthesize queue = _queue;
@synthesize storageQueue = _storageQueue;
@synthesize batchQueue = _batchQueue;

//MARK: Initiailziation

/**
 Initializes a CWQueue object with no contents
 
 Initializes & returns an empty CWQueue object ready to
 accept objects to be added to it.
 
 @return a CWQueue object ready to accept objects to be added to it.
 */
-(id)init
{
	self = [super init];
	if (self) {
		_queue = [[NSMutableArray alloc] init];
		_storageQueue = dispatch_queue_create(CWUUIDCStringPrependedWithString(@"com.Zangetsu.CWQueue_"), DISPATCH_QUEUE_SERIAL);
		_batchQueue = dispatch_queue_create(CWUUIDCStringPrependedWithString(@"com.Zangetsu.CWQueue_"), DISPATCH_QUEUE_SERIAL);
	}
	return self;
}

-(id)initWithObjectsFromArray:(NSArray *)array
{
	self = [super init];
	if (self) {
		if ([array count] > 0) {
			_queue = [[NSMutableArray alloc] initWithArray:array];
		} else {
			_queue = [[NSMutableArray alloc] init];
		}
		_storageQueue = dispatch_queue_create(CWUUIDCStringPrependedWithString(@"com.Zangetsu.CWQueue_"), DISPATCH_QUEUE_SERIAL);
		_batchQueue = dispatch_queue_create(CWUUIDCStringPrependedWithString(@"com.Zangetsu.CWQueue_"), DISPATCH_QUEUE_SERIAL);
	}
	return self;
}

//MARK: Add & Remove Objects

-(id)dequeue
{
	__block id object = nil;
	dispatch_sync(_storageQueue, ^{
		if ([self.queue count] == 0) { return; }
		object = [self.queue objectAtIndex:0]; //change back to cw_firstObject sometime
		[self.queue removeObjectAtIndex:0];
	});
	return object;
}

-(void)enqueue:(id)object
{
	if (object) {
		dispatch_async(_storageQueue, ^{
			[self.queue addObject:object];
		});
	}
}

-(void)enqueueObjectsFromArray:(NSArray *)objects
{
	if (objects && ([objects count] > 0)) {
		dispatch_async(_storageQueue, ^{
			[self.queue addObjectsFromArray:objects];
		});
	}
}

-(void)removeAllObjects
{
	dispatch_async(_storageQueue, ^{
		[self.queue removeAllObjects];
	});
}

//MARK: Query Methods

-(BOOL)containsObject:(id)object
{
	__block BOOL contains = NO;
	dispatch_sync(_storageQueue, ^{
		contains = [self.queue containsObject:object];
	});
	return contains;
}

-(BOOL)containsObjectWithBlock:(BOOL (^)(id obj))block
{
	__block BOOL contains = NO;
	dispatch_sync(_storageQueue, ^{
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
	dispatch_sync(_storageQueue, ^{
		object = [self.queue cw_firstObject];
	});
	return object;
}

//MARK: Enumeration Methods

-(void)enumerateObjectsInQueue:(void(^)(id object, BOOL *stop))block
{
	dispatch_sync(_storageQueue, ^{
		BOOL shouldStop = NO;
		for (id object in self.queue) {
			block(object,&shouldStop);
			if (shouldStop) { return; }
		}
	});
}

-(void)dequeueOueueWithBlock:(void(^)(id object, BOOL *stop))block
{
	dispatch_sync(_batchQueue, ^{
		if([self.queue count] == 0) { return; }
		
		BOOL shouldStop = NO;
		id dequeuedObject = nil;
		
		do {
			dequeuedObject = [self dequeue];
			if(dequeuedObject){
				block(dequeuedObject,&shouldStop);
			}
		} while ((shouldStop == NO) && (dequeuedObject));
	});
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
	dispatch_sync(_batchQueue, ^{ }); //sync
}

//MARK: Debug Information

/**
 Returns an NSString with a description of the queues storage
 
 @return a NSString detailing the queues internal storage
 */
-(NSString *)description
{
	__block NSString *queueDescription = nil;
	dispatch_sync(_storageQueue, ^{
		queueDescription = [self.queue description];
	});
	return queueDescription;
}

-(NSUInteger)count
{
	__block NSUInteger queueCount = 0;
	dispatch_sync(_storageQueue, ^{
		queueCount = [self.queue count];
	});
	return queueCount;
}

-(BOOL)isEmpty
{
	__block BOOL queueEmpty = YES;
	dispatch_sync(_storageQueue, ^{
		queueEmpty = ([self.queue count] == 0);
	});
	return queueEmpty;
}

//MARK: Comparison

-(BOOL)isEqualToQueue:(CWQueue *)aQueue
{
	__block BOOL isEqual;
	dispatch_sync(_storageQueue, ^{
		isEqual = [self.queue isEqual:aQueue.queue];
	});
	return isEqual;
}

-(void)dealloc
{
	dispatch_release(_storageQueue);
	dispatch_release(_batchQueue);
}

@end
