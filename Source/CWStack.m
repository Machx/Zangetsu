/*
//  CWStack.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/24/11.
//  Copyright 2012. All rights reserved.
//
 
 */

#import "CWStack.h"

@interface CWStack()
@property(retain) NSMutableArray *stack;
@property(assign) dispatch_queue_t queue;
@end

@implementation CWStack

/**
 Initializes an empty stack
 
 @return a empty CWStack instance
 */
- (id)init
{
    self = [super init];
    if (self) {
		_stack = [[NSMutableArray alloc] init];
		_queue = dispatch_queue_create(CWUUIDCStringPrependedWithString(@"com.Zangetsu.CWStack_"), DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

-(id)initWithObjectsFromArray:(NSArray *)objects
{
	self = [super init];
	if (self) {
		_stack = [[NSMutableArray alloc] init];
		_queue = dispatch_queue_create(CWUUIDCStringPrependedWithString(@"com.Zangetsu.CWStack_"), DISPATCH_QUEUE_SERIAL);
		if ([objects count] > 0) {
			[_stack addObjectsFromArray:objects];
		}
	}
	return self;
}

-(void)push:(id)object
{
	dispatch_async(self.queue, ^{
		if (object) {
			[self.stack addObject:object];
		}
	});
}

-(id)pop
{
	__block id object;
	dispatch_sync(self.queue, ^{
		if ([self.stack count] == 0) {
			object = nil;
		} else {
			object = [self.stack lastObject];
			[self.stack removeLastObject];
		}
	});
	return object;
}

-(NSArray *)popToObject:(id)object
{	
	__block NSMutableArray *poppedObjects = nil;
	if (![self.stack containsObject:object]) { return nil; }
	
	id currentObject = nil;
	while (![self.topOfStackObject isEqual:object]) {
		currentObject = [self pop];
		[poppedObjects addObject:currentObject];
	}
	
	return poppedObjects;
}

-(void)popToObject:(id)object withBlock:(void (^)(id obj))block
{	
	if (![self.stack containsObject:object]) { return; }
	
	while (![self.topOfStackObject isEqual:object]) {
		id obj = [self pop];
		block(obj);
	}
}

-(NSArray *)popToBottomOfStack
{
	__block NSArray *poppedObjects = nil;
	
	if(self.stack.count == 0) { return nil; }
	poppedObjects = [self popToObject:[[self stack] cw_firstObject]];
	
	return poppedObjects;
}

-(id)topOfStackObject
{
	__block id object = nil;
	dispatch_sync(self.queue, ^{
		if([self.stack count] == 0) { return; }
		object = [self.stack lastObject];
	});
	return object;
}

-(id)bottomOfStackObject
{
	__block id object = nil;
	dispatch_sync(self.queue, ^{
		if ([self.stack count] == 0) { return; }
		object = [self.stack cw_firstObject];
	});
	return object;
}

-(void)clearStack
{
	dispatch_async(self.queue, ^{
		[self.stack removeAllObjects];
	});
}

-(BOOL)isEqualToStack:(CWStack *)aStack
{
	__block BOOL isEqual = NO;
	dispatch_sync(self.queue, ^{
		isEqual = [[aStack description] isEqualToString:[self.stack description]];
	});
	return isEqual;
}

-(BOOL)containsObject:(id)object
{
	__block BOOL contains = NO;
	dispatch_sync(self.queue, ^{
		contains = [self.stack containsObject:object];
	});
	return contains;
}

-(BOOL)containsObjectWithBlock:(BOOL (^)(id object))block
{	
	__block BOOL contains = NO;
	dispatch_sync(self.queue, ^{
		for (id obj in self.stack) {
			if (block(obj)) {
				contains = YES;
				break;
			}
		}
	});
	return contains;
}

/**
 returns a NSString with the contents of the stack
 
 @return a NSString object with the description of the stack contents
 */
-(NSString *)description
{
	__block NSString *stackDescription = nil;
	dispatch_sync(self.queue, ^{
		stackDescription = [self.stack description];
	});
	return stackDescription;
}

-(BOOL)isEmpty
{
    __block BOOL empty;
	dispatch_sync(self.queue, ^{
		empty = ([self.stack count] <= 0);
	});
	return empty;
}

-(NSInteger)count
{
    __block NSInteger theCount = 0;
	dispatch_sync(self.queue, ^{
		theCount = [self.stack count];
	});
	return theCount;
}

-(void)dealloc
{
	dispatch_release(_queue);
}

@end
