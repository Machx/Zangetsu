//
//  CWLightBlockQueueTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 2/24/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "CWSerialBlockQueueTests.h"
#import "CWAssertionMacros.h"
#import "CWSerialBlockQueue.h"

SpecBegin(CWSerialBlockQueue)

it(@"should enqueue an operation and execute it right away", ^{
	NSString *goodResult = @"Hello World!";
	__block NSString *result = nil;
	
	CWSerialBlockOperation *op = [CWSerialBlockOperation blockOperationWithBlock:^{
		result = @"Hello World!";
	}];
	
	CWSerialBlockQueue *queue = [[CWSerialBlockQueue alloc] initWithLabel:nil];
	[queue addBlockOperation:op];
	
	expect(result).will.equal(goodResult);
});

describe(@"-addOperationWithBlock", ^{
	it(@"should execute an operation asap", ^{
		NSString *goodResult = @"Hello There!";
		__block NSString *result = nil;
		
		CWSerialBlockQueue *queue = [[CWSerialBlockQueue alloc] init];
		[queue addOperationwithBlock:^{
			result = @"Hello There!";
		}];
		
		expect(result).will.equal(goodResult);
	});
});

describe(@"-suspend", ^{
	it(@"should suspend executing blocks on the queue", ^{
		NSString *goodResult = @"001100010010011110100001101101110011";
		__block NSString *result = nil;
		CWSerialBlockQueue *queue = [[CWSerialBlockQueue alloc] init];
		
		[queue suspend];
		[queue addOperationwithBlock:^{
			result = [goodResult copy];
		}];
		
		expect(result).to.beNil();
		
		[queue resume];
		
		expect(result).will.equal(goodResult);
	});
});

SpecEnd
