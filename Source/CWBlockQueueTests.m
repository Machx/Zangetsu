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
	
	CWBlockQueue *queue = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetGCDNormalPriority
													   concurrent:YES
															label:nil];
	
	[queue addoperationWithBlock:^{
		result = @"Hello World!";
	}];
	
	[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
	
	CWAssertEqualsStrings(@"Hello World!", result);
}

@end
