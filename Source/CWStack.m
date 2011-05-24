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
	[stack addObject:object];
}

-(id)pop {
	id lastObject = [[[self stack] lastObject] copy];
	
	[[self stack] removeLastObject];
	
	return lastObject;
}

-(id)topOfStackObject {
	return [[self stack] lastObject];
}

@end
