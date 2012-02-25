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
		result = @"Hello World!";
		NSLog(@"Hello World!");
	}];
	
	CWLightBlockQueue *queue = [[CWLightBlockQueue alloc] initWithBlockOperationObjects:[NSArray arrayWithObject:op]
																	 processImmediately:YES];
	
	[queue waitUntilAllBlocksHaveProcessed];
	
	[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
	
	CWAssertEqualsStrings(result, goodResult);
}

@end
