//
//  CWBlockQueueTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 2/27/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "CWBlockQueueTests.h"
#import "CWBlockQueue.h"
#import "CWAssertionMacros.h"

@implementation CWBlockQueueTests

-(void)testBasicOperation
{
	__block NSString *result = nil;
	
	CWBlockQueue *queue = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetPrivateQueue
													   concurrent:YES
															label:nil];
	
	[queue addoperationWithBlock:^{
		result = @"Hello World!";
	}];
	
	[queue waitForQueueToFinish];
	
	CWAssertEqualsStrings(@"Hello World!", result);
}

-(void)testCompletionBlock
{
	__block NSString *result = nil;
	
	CWBlockQueue *queue = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetPrivateQueue
													   concurrent:YES 
															label:nil];
	
	CWBlockOperation *operation = [CWBlockOperation operationWithBlock:^{
		NSLog(@"Obey Hypnotoad!");
	}];
	
	[operation setCompletionBlock:^{
		result = [NSString stringWithString:@"Obey Hypnotoad!"];
	}];
	
	[queue addOperation:operation];
	
	[queue waitForQueueToFinish];
	
	CWAssertEqualsStrings(@"Obey Hypnotoad!", result);
}

@end
