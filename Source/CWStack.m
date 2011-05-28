//
//  CWStack.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/24/11.
//  Copyright 2011. All rights reserved.
//

#import "CWStack.h"

@interface CWStack()
//Private internal ivar
@property(nonatomic, retain) NSMutableArray *stack;
@end

@implementation CWStack

@synthesize stack;

- (id)init
{
    self = [super init];
    if (self) {
		stack = [[NSMutableArray alloc] init];
    }
    
    return self;
}

/**
 initializes a CWStack object with the content of the array passed in
 
 If the NSArray passed in has at least 1 object
 
 @param objects a NSArray whose contents you want a CWStack object initialized with
 @return an intialized CWStack object
 */
-(id)initWithObjectsFromArray:(NSArray *)objects {
	self = [super init];
	if (self) {
		stack = [[NSMutableArray alloc] init];
		if ([objects count] > 0) {
			[stack addObjectsFromArray:objects];
		}
	}
	
	return self;
}

/**
 pushes an object onto the stack
 
 @param object the object you want pushed onto the stack
 */
-(void)push:(id)object {
	[[self stack] addObject:object];
}

/**
 pops an object off of the top of the CWStack object and returns that popped object
 
 @return the object at the top of the stack
 */
-(id)pop {
	id lastObject = [[self stack] lastObject];
	
	[[self stack] removeLastObject];
	
	return lastObject;
}

/**
 continuously pops objects off the stack until the object specified is found
 
 popToObject pops all objects off the stack until it finds the object specified in the 
 passed in value. If the object is not in the stack it returns nil immediately, otherwise 
 a NSArray containing all objects popped off the stack before the object specified is returned
 
 @param object the object you wish the stack to be popped off to
 @return nil if the object is not in the array otherwise a NSArray of all popped off objects
 */
-(NSArray *)popToObject:(id)object {
	if (![[self stack] containsObject:object]) {
		return nil;
	}
	
	NSMutableArray *stackArray = [[NSMutableArray alloc] init];
	id currentObject = nil;
	while (![[self topOfStackObject] isEqual:object]) {
		currentObject = [self pop];
		[stackArray addObject:currentObject];
	}
	
	return stackArray;
}

-(void)popToObject:(id)object withBlock:(stackBlock)block {
	if (![[self stack] containsObject:object]) {
		return;
	}
	
	while (![[self topOfStackObject] isEqual:object]) {
		id obj = [self pop];
		block(obj);
	}
}

/**
 pops all objects off the stack except for the bottom object
 
 @return a NSArray of all popped off objects
 */
-(NSArray *)popToBottomOfStack {	
	NSArray *stackArray = [self popToObject:[[self stack] cw_firstObject]];
	
	return stackArray;
}

/**
 returns the object at the top of the stack
 
 @return the objct at the top of the stack
 */
-(id)topOfStackObject {
	return [[self stack] lastObject];
}

/**
 returns the object at the bottom of the stack
 
 @return the objct at the bottom of the stack
 */
-(id)bottomOfStackObject {
	return [[self stack] cw_firstObject];
}

/**
 clears the stack of all objects
 */
-(void)clearStack {
	[[self stack] removeAllObjects];
}

-(NSString *)description {
	return [[self stack] description];
}

@end
