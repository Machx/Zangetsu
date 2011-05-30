//
//  CWStackTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CWStackTests.h"
#import "CWStack.h"

@implementation CWStackTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

-(void)testBasicPush {
	
	NSArray *array = [NSArray arrayWithObjects:@"This",@"is",@"a",@"sentence", nil];
	
	CWStack *stack1 = [[CWStack alloc] init];
	
	CWStack *stack2 = [[CWStack alloc] initWithObjectsFromArray:array];
	
	[stack1 push:[array objectAtIndex:0]];
	[stack1 push:[array objectAtIndex:1]];
	[stack1 push:[array objectAtIndex:2]];
	[stack1 push:[array objectAtIndex:3]];
	
	STAssertTrue([[stack1 description] isEqualToString:[stack2 description]], @"stacks should be equal");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
