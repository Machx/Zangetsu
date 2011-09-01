/*
//  CWStackTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/30/11.
//  Copyright 2011. All rights reserved.
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
	
    STAssertTrue([stack1 isEqualToStack:stack2], @"stack contents should be equal");
    STAssertFalse([stack1 isEqualTo:stack2], @"stacks shouldnt be the same object");
}

-(void)testBasicEnumeration {
	
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

-(void)testClearStack {
	
	CWStack *stack1 = [[CWStack alloc] initWithObjectsFromArray:[NSArray arrayWithObjects:@"one",@"and",@"two", nil]];
	CWStack *stack2 = [[CWStack alloc] initWithObjectsFromArray:[NSArray arrayWithObjects:@"foo",@"bar",nil]];
	
	[stack1 clearStack];
	[stack2 clearStack];
	
	STAssertTrue([[stack1 description] isEqualToString:[stack2 description]], @"stacks should be equal");
}

-(void)testBottomAndTopStackObjects {
	
	NSArray *array = [NSArray arrayWithObjects:@"This",@"is",@"a",@"sentence", nil];
	
	CWStack *stack = [[CWStack alloc] initWithObjectsFromArray:array];
	
	STAssertTrue([(NSString *)[stack bottomOfStackObject] isEqualToString:@"This"], @"Bottom stack object should be equal");
	STAssertTrue([(NSString *)[stack topOfStackObject] isEqualToString:@"sentence"], @"Top of stack object should be equal");
}

-(void)testPopToBottomOfStack {
	
	NSArray *array = [NSArray arrayWithObjects:@"This",@"is",@"a",@"sentence", nil];
	
	CWStack *stack = [[CWStack alloc] initWithObjectsFromArray:array];
	
	[stack popToBottomOfStack];
	
	CWStack *stack2 = [[CWStack alloc] initWithObjectsFromArray:[NSArray arrayWithObject:@"This"]];
	
	STAssertTrue([[stack description] isEqualToString:[stack2 description]], @"stacks should be equal");
}

-(void)testEmptyStack {
    
    CWStack *stack = [[CWStack alloc] init];
    
    STAssertTrue([stack isEmpty], @"stack should be empty");
    
    [stack push:@"All Glory to the Hypnotoad"];
    
    STAssertFalse([stack isEmpty], @"stack should not be empty");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
