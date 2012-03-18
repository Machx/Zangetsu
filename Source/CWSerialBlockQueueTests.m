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

@implementation CWSerialBlockQueueTests

-(void)testBasicBlockExecution
{
	NSString *goodResult = @"Hello World!";
	__block NSString *result = nil;
	
	CWSerialBlockOperation *op = [CWSerialBlockOperation blockOperationWithBlock:^{
		result = @"Hello World!";
	}];
	
	CWSerialBlockQueue *queue = [[CWSerialBlockQueue alloc] initWithBlockOperationObjects:[NSArray arrayWithObject:op]];
	
	[queue waitUntilAllBlocksHaveProcessed];
	
	CWAssertEqualsStrings(result, goodResult);
}

-(void)testAddOperationWithBlock
{
	NSString *goodResult = @"Hello There!";
	__block NSString *result = nil;
	
	CWSerialBlockQueue *queue = [[CWSerialBlockQueue alloc] init];
	
	[queue addOperationwithBlock:^{
		result = @"Hello There!";
	}];
	
	[queue waitUntilAllBlocksHaveProcessed];
	
	CWAssertEqualsStrings(result, goodResult);
}

-(void)testSuspension
{
	NSString *goodResult = @"001100010010011110100001101101110011";
	__block NSString *result = nil;
	
	CWSerialBlockQueue *queue = [[CWSerialBlockQueue alloc] init];
	
	[queue suspend];
	
	[queue addOperationwithBlock:^{
		result = [goodResult copy];
	}];
	
	STAssertNil(result,@"block should not have run yet, so result should be nil");
	
	[queue resume];
	
	[queue waitUntilAllBlocksHaveProcessed];
	
	CWAssertEqualsStrings(goodResult, result);
}

@end
