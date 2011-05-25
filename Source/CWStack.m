//
//  CWStack.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/24/11.
//  Copyright 2011. All rights reserved.
//

#import "CWStack.h"

@interface CWStack()
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

-(id)initWithObjectsFromArray:(NSArray *)objects {
	self = [super init];
	if (self) {
		stack = [[NSMutableArray alloc] init];
		[stack addObjectsFromArray:objects];
	}
	
	return self;
}

-(void)push:(id)object {
	[[self stack] addObject:object];
}

-(id)pop {
	id lastObject = [[self stack] lastObject];
	
	[[self stack] removeLastObject];
	
	return lastObject;
}

-(id)popToObject:(id)object {
	if (![[self stack] containsObject:object]) {
		return nil;
	}
	
	id currentObject = nil;
	while (![[self topOfStackObject] isEqual:object]) {
		currentObject = [self pop];
	}
	
	return currentObject;
}

-(id)topOfStackObject {
	return [[self stack] lastObject];
}

-(NSString *)description {
	return [[self stack] description];
}

@end
