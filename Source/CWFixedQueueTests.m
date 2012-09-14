//
//  CWFixedQueueTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 9/11/12.
//
//

#import "CWFixedQueueTests.h"
#import "CWFixedQueue.h"
#import "CWAssertionMacros.h"

@implementation CWFixedQueueTests

-(void)testBasicQueueProperties
{
	CWFixedQueue *queue = [CWFixedQueue new];
	queue.capacity = 2;
	
	STAssertTrue([queue count] == 0, nil);
	[queue enqueue:@"Good"];
	STAssertTrue([queue count] == 1, nil);
	[queue enqueue:@"News"];
	STAssertTrue([queue count] == 2, nil);
	[queue enqueue:@"Everybody!"];
	STAssertTrue([queue count] == 2, nil);
	
	[queue enumerateContents:^(id object, NSUInteger index, BOOL *stop) {
		switch (index) {
			case 0:
				CWAssertEqualsStrings(object,@"News");
				break;
			case 1:
				CWAssertEqualsStrings(object, @"Everybody!");
				break;
			default:
				STFail(@"Enumerated past collection objects bounds");
				break;
		}
	}];
	
	NSString *result = [queue dequeue];
	CWAssertEqualsStrings(result,@"News");
	
	result = [queue dequeue];
	CWAssertEqualsStrings(result, @"Everybody!");
}

-(void)testEnqueueObjectsFromArray
{
	CWFixedQueue *queue = [CWFixedQueue new];
	queue.capacity = 2;
	
	[queue enqueueObjectsInArray:@[ @"Nope",@"Everybody Watch",@"Hypnotoad" ]];
	STAssertTrue([queue count] == 2, nil);
	
	[queue enumerateContents:^(id object, NSUInteger index, BOOL *stop) {
		switch (index) {
			case 0:
				CWAssertEqualsStrings(object, @"Everybody Watch");
				break;
			case 1:
				CWAssertEqualsStrings(object, @"Hypnotoad");
				break;
			default:
				STFail(@"enumerated past array bounds");
				break;
		}
	}];
}

-(void)testObjectSubscripting
{
	CWFixedQueue *queue = [CWFixedQueue new];
	queue.capacity = 2;
	
	[queue enqueueObjectsInArray:@[ @"Everybody Watch",@"Hypnotoad" ]];
	
	CWAssertEqualsStrings(queue[0], @"Everybody Watch");
	CWAssertEqualsStrings(queue[1], @"Hypnotoad");
	
	queue[0] = @"Obey";
	CWAssertEqualsStrings(queue[0], @"Obey");
}

@end
