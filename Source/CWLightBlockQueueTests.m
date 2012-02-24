//
//  CWLightBlockQueueTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 2/24/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "CWLightBlockQueueTests.h"
#import "CWAssertionMacros.h"
#import "CWLightBlockQueue.h"

@implementation CWLightBlockQueueTests

-(void)testBasicBlockExecution
{
	NSString *goodResult = @"Hello World!";
	__block NSString *result = nil;
	
	CWLightBlockOperation *op = [CWLightBlockOperation blockOperationWithBlock:^{
		result = [NSString stringWithString:goodResult];
	}];
	
	[op setCompletionBlock:^{
		CWAssertEqualsStrings(result, goodResult);
	}];
	
	CWLightBlockQueue *queue = [[CWLightBlockQueue alloc] initWithBlockOperationObjects:[NSArray arrayWithObject:op]
																	 processImmediately:NO];
	[queue startProcessingBlocks];
}

@end
