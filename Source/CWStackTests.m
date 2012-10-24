/*
//  CWStackTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/30/11.
//  Copyright 2012. All rights reserved.
//
 
 */

#import "CWStackTests.h"
#import "CWStack.h"

@implementation CWStackTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

-(void)testBasicPush
{	
	NSArray *array = [NSArray arrayWithObjects:@"This",@"is",@"a",@"sentence", nil];
	
	CWStack *stack1 = [[CWStack alloc] init];
	
	CWStack *stack2 = [[CWStack alloc] initWithObjectsFromArray:array];
	
	[stack1 push:[array objectAtIndex:0]];
	[stack1 push:[array objectAtIndex:1]];
	[stack1 push:[array objectAtIndex:2]];
	[stack1 push:[array objectAtIndex:3]];
	
    STAssertTrue([stack1 isEqualToStack:stack2], @"stack contents should be equal");
    STAssertFalse([stack1 isEqualTo:stack2], @"stacks shouldnt be the same object");
}

-(void)testPushNil
{	
	CWStack *testStack = [[CWStack alloc] initWithObjectsFromArray:[NSArray arrayWithObject:@"Nibbler"]];
	STAssertTrue([testStack count] == 1, @"Stack should only have 1 object contained in it");
	
	[testStack push:nil];
	STAssertTrue([testStack count] == 1, @"Stack have ignored nil and done nothing");
}

-(void)testBasicEnumeration
{	
	NSArray *array = [NSArray arrayWithObjects:@"This",@"is",@"a",@"sentence", nil];
	
	CWStack *stack = [[CWStack alloc] initWithObjectsFromArray:array];
	
	__block NSInteger index = 0;
	
	[stack popToObject:@"This" withBlock:^(id obj) {
		if (index == 0) {
			STAssertTrue([(NSString *)obj isEqualToString:@"sentence"], @"strings should be equal");
			index++;
		} else if (index == 1) {
			STAssertTrue([(NSString *)obj isEqualToString:@"a"], @"strings should be equal");
			index++;
		} else if (index == 2) {
			STAssertTrue([(NSString *)obj isEqualToString:@"is"], @"strings should be equal");
			index++;
		} else {
			STAssertTrue(FALSE, @"should not get here");
		}
	}];
}

-(void)testClearStack
{	
	CWStack *stack1 = [[CWStack alloc] initWithObjectsFromArray:[NSArray arrayWithObjects:@"one",@"and",@"two", nil]];
	CWStack *stack2 = [[CWStack alloc] initWithObjectsFromArray:[NSArray arrayWithObjects:@"foo",@"bar",nil]];
	
	[stack1 clearStack];
	[stack2 clearStack];
	
	STAssertTrue([[stack1 description] isEqualToString:[stack2 description]], @"stacks should be equal");
}

-(void)testBottomAndTopStackObjects
{	
	NSArray *array = [NSArray arrayWithObjects:@"This",@"is",@"a",@"sentence", nil];
	
	CWStack *stack = [[CWStack alloc] initWithObjectsFromArray:array];
	
	STAssertTrue([(NSString *)[stack bottomOfStackObject] isEqualToString:@"This"], @"Bottom stack object should be equal");
	STAssertTrue([(NSString *)[stack topOfStackObject] isEqualToString:@"sentence"], @"Top of stack object should be equal");
}

-(void)testNilBottomAndTopStackObjects
{	
	CWStack *stack = [[CWStack alloc] init];
	
	STAssertNil([stack bottomOfStackObject], @"Since there are no objects on the stack it should return a nil reference");
	STAssertNil([stack topOfStackObject], @"Since there are no objects on the stack it should return nil");
	
	[stack push:@"Why not Zoidberg?"];
	STAssertTrue([stack count] == 1, @"Stack should have an object");
	STAssertNotNil([stack bottomOfStackObject], @"Since there is an object on the stack it should return a non nil reference");
	STAssertNotNil([stack topOfStackObject], @"Since there is an object on the stack it should return non nil");
	
	[stack pop];
	STAssertTrue([stack count] == 0, @"Stack should not have an object");
	STAssertNil([stack bottomOfStackObject], @"Since there are no objects on the stack it should return a nil reference");
	STAssertNil([stack topOfStackObject], @"Since there are no objects on the stack it should return nil");
}

-(void)testPopToBottomOfStack
{
	NSArray *array = [NSArray arrayWithObjects:@"This",@"is",@"a",@"sentence", nil];
	
	CWStack *stack = [[CWStack alloc] initWithObjectsFromArray:array];
	
	[stack popToBottomOfStack];
	
	CWStack *stack2 = [[CWStack alloc] initWithObjectsFromArray:[NSArray arrayWithObject:@"This"]];
	
	STAssertTrue([[stack description] isEqualToString:[stack2 description]], @"stacks should be equal");
}

-(void)testPoptoNonExistantObject
{
	CWStack *stack = [[CWStack alloc] initWithObjectsFromArray:[NSArray arrayWithObject:@"Bender"]];
	
	NSArray *results = [stack popToObject:@"Zapf"];
	STAssertNil(results, @"Since the stack didn't contain this object it, the returned reference should be nil");
}

-(void)testEmptyStack
{
    CWStack *stack = [[CWStack alloc] init];
    
    STAssertTrue([stack isEmpty], @"stack should be empty");
    
    [stack push:@"All Glory to the Hypnotoad"];
    
    STAssertFalse([stack isEmpty], @"stack should not be empty");
}

-(void)testContainsObject
{
	CWStack *stack = [[CWStack alloc] initWithObjectsFromArray:[NSArray arrayWithObjects:@"Hello",@"World", nil]];
	
	// test for an object in the stack
	
	BOOL result = [stack containsObject:@"Hello"];
	
	STAssertTrue(result,@"The Stack should contain the object");
	
	// test for an object we know isn't in the stack
	
	BOOL result2 = [stack containsObject:@"Planet Express"];
	
	STAssertFalse(result2,@"Object should not be in the stack");
}

-(void)testContainsObjectWithBlock
{
	CWStack *stack = [[CWStack alloc] initWithObjectsFromArray:[NSArray arrayWithObjects:@"Hello",@"World", nil]];
	
	BOOL result = [stack containsObjectWithBlock:^BOOL(id object) {
		if ([(NSString *)object isEqualToString:@"World"]) {
			return YES;
		}
		return NO;
	}];
	
	STAssertTrue(result,@"The string 'World' should be in the stack");
	
	BOOL result2 = [stack containsObjectWithBlock:^BOOL(id object) {
		if ([(NSString *)object isEqualToString:@"Hypnotoad"]) {
			return YES;
		}
		return NO;
	}];
	
	STAssertFalse(result2,@"Hypnotoad shoudln't be in this stack");
}

- (void)tearDown {
    // Tear-down code here.
    
    [super tearDown];
}

@end
