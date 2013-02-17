/*
//  CWStackTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/30/11.
//  Copyright 2012. All rights reserved.
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

#import "CWStackTests.h"
#import "CWStack.h"

//TODO: these unit tests can be improved a lot more

SpecBegin(CWStackTests)

describe(@"-push", ^{
	it(@"should add objects to the stack", ^{
		NSArray *array = @[ @"This", @"is", @"a", @"sentence" ];
		CWStack *stack = [[CWStack alloc] init];
		
		[stack push:array[0]];
		expect(stack.count == 1).to.beTruthy();
		expect(stack.topOfStackObject).to.equal(@"This");
		
		[stack push:array[1]];
		expect(stack.count == 2).to.beTruthy();
		expect(stack.topOfStackObject).to.equal(@"is");
		
		[stack push:array[2]];
		expect(stack.count == 3).to.beTruthy();
		expect(stack.topOfStackObject).to.equal(@"a");
		
		[stack push:array[3]];
		expect(stack.count == 4).to.beTruthy();
		expect(stack.topOfStackObject).to.equal(@"sentence");
	});
	
	it(@"should not accept pushing nil onto the stack", ^{
		CWStack *testStack = [[CWStack alloc] initWithObjectsFromArray:@[ @"Nibbler" ]];
		expect(testStack.count == 1).to.beTruthy();
		expect(testStack.topOfStackObject).to.equal(@"Nibbler");
		
		[testStack push:nil];
		expect(testStack.count == 1).to.beTruthy();
		expect(testStack.topOfStackObject).to.equal(@"Nibbler");
	});
});

describe(@"-popToObject:withBlock:", ^{
	it(@"should pop objects in the sequence expected", ^{
		NSArray *array = @[ @"This", @"is", @"a", @"sentence" ];
		CWStack *stack = [[CWStack alloc] initWithObjectsFromArray:array];
		__block NSInteger index = 0;
		
		[stack popToObject:@"This" withBlock:^(id obj) {
			if (index == 0) {
				expect(obj).to.equal(@"sentence");
			} else if (index == 1) {
				expect(obj).to.equal(@"a");
			} else if (index == 2) {
				expect(obj).to.equal(@"is");
			} else {
				STFail(@"We have enumerated past the expected bounds");
			}
			index++;
		}];
	});
});

describe(@"-clearStack", ^{
	it(@"should clear all the objects off a stack", ^{
		CWStack *stack1 = [[CWStack alloc] initWithObjectsFromArray:@[@"one",@"and",@"two"]];
		CWStack *stack2 = [[CWStack alloc] initWithObjectsFromArray:@[@"foo",@"bar"]];
		
		expect(stack1.count == 3).to.beTruthy();
		expect(stack2.count == 2).to.beTruthy();
		
		[stack1 clearStack];
		[stack2 clearStack];
		
		expect(stack1.count == 0).to.beTruthy();
		expect(stack2.count == 0).to.beTruthy();
		expect([stack1 isEqualToStack:stack2]).to.beTruthy();
	});
});

describe(@"bottomOfStackObject", ^{
	it(@"should find the correct object at the bottom of a stack", ^{
		CWStack *stack = [[CWStack alloc] initWithObjectsFromArray:@[@"This",@"is",@"a",@"sentence"]];
		expect(stack.bottomOfStackObject).to.equal(@"This");
	});
	
	it(@"should return nil when there are no objects on the stack", ^{
		CWStack *stack = [CWStack new];
		expect(stack.bottomOfStackObject).to.beNil();
	});
});

describe(@"topOfStackObject", ^{
	it(@"should find the correct object at the top of a stack", ^{
		CWStack *stack = [[CWStack alloc] initWithObjectsFromArray:@[@"This",@"is",@"a",@"sentence"]];
		expect(stack.topOfStackObject).to.equal(@"sentence");
	});
	
	it(@"should return nil when there are no objects on the stack", ^{
		CWStack *stack = [CWStack new];
		expect(stack.topOfStackObject).to.beNil();
	});
});

describe(@"-popToBottomOfStack", ^{
	it(@"should pop all objects except the bottom object off the stack", ^{
		CWStack *stack = [[CWStack alloc] initWithObjectsFromArray:@[@"This",@"is",@"a",@"sentence"]];
		
		expect(stack.count == 4).to.beTruthy();
		
		[stack popToBottomOfStack];
		
		expect(stack.count == 1).to.beTruthy();
		
		CWStack *stack2 = [[CWStack alloc] initWithObjectsFromArray:@[@"This"]];
		
		expect([stack isEqualToStack:stack2]).to.beTruthy();
	});
});

describe(@"-popToObject", ^{
	it(@"should return nil for non existant objects", ^{
		CWStack *stack = [[CWStack alloc] initWithObjectsFromArray:@[@"Bender"]];
		NSArray *results = [stack popToObject:@"Zapf"];
		
		expect(results).to.beNil();
	});
});

describe(@"-isEmpty", ^{
	it(@"should correctly return when the stack is empty", ^{
		CWStack *stack = [CWStack new];
		
		expect(stack.isEmpty).to.beTruthy();
		
		[stack push:@"All Glory to the Hypnotoad"];
		
		expect(stack.isEmpty).to.beFalsy();
	});
});

describe(@"-containsObject", ^{
	it(@"should correctly return when the stack does contain an object", ^{
		CWStack *stack = [[CWStack alloc] initWithObjectsFromArray:@[@"Hello",@"World"]];
		
		expect([stack containsObject:@"Hello"]).to.beTruthy();
		expect([stack containsObject:@"Planet Express"]).to.beFalsy();
	});
});

describe(@"-containsObjectWithBlock", ^{
	it(@"should correctly return if an object says the stack contains an object", ^{
		CWStack *stack = [[CWStack alloc] initWithObjectsFromArray:@[@"Hello",@"World"]];
		BOOL result = [stack containsObjectWithBlock:^BOOL(id object) {
			if ([(NSString *)object isEqualToString:@"World"]) return YES;
			return NO;
		}];
		
		expect(result).to.beTruthy();
		
		BOOL result2 = [stack containsObjectWithBlock:^BOOL(id object) {
			if ([(NSString *)object isEqualToString:@"Hypnotoad"]) return YES;
			return NO;
		}];
		
		expect(result2).to.beFalsy();
	});
});

SpecEnd
