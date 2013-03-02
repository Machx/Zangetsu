//
//  CWFixedQueueTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 9/11/12.
//
//

#import "CWFixedQueueTests.h"
#import "CWFixedQueue.h"

SpecBegin(CWFixedQueue)

it(@"should enqueue & dequeue objects as expected", ^{
	CWFixedQueue *queue = [CWFixedQueue new];
	queue.capacity = 2;
	
	expect(queue.count == 0).to.beTruthy();
	
	[queue enqueue:@"Good"];
	expect(queue.count == 1).to.beTruthy();
	
	[queue enqueue:@"News"];
	expect(queue.count == 2).to.beTruthy();
	
	[queue enqueue:@"Everybody!"];
	expect(queue.count == 2).to.beTruthy();
	
	[queue enumerateContents:^(id object, NSUInteger index, BOOL *stop) {
		if (index == 0) {
			expect(object).to.equal(@"News");
		} else if (index == 1) {
			expect(object).to.equal(@"Everybody!");
		} else {
			STFail(@"Enumerated past bounds");
		}
	}];
	
	expect([queue dequeue]).to.equal(@"News");
	expect([queue dequeue]).to.equal(@"Everybody!");
});

describe(@"-enqueueObjectsFromArray", ^{
	it(@"should enqueue objects from an array as expected", ^{
		CWFixedQueue *queue = [CWFixedQueue new];
		queue.capacity = 2;
		
		[queue enqueueObjectsInArray:@[ @"Nope",@"Everybody Watch",@"Hypnotoad" ]];
		expect(queue.count == 2).to.beTruthy();
		
		[queue enumerateContents:^(id object, NSUInteger index, BOOL *stop) {
			if (index == 0) {
				expect(object).to.equal(@"Everybody Watch");
			} else if (index == 1) {
				expect(object).to.equal(@"Hypnotoad");
			} else {
				STFail(@"Enumerated past bounds");
			}
		}];
	});
});

it(@"should work with object subscripting", ^{
	CWFixedQueue *queue = [CWFixedQueue new];
	queue.capacity = 2;
	[queue enqueueObjectsInArray:@[ @"Everybody Watch",@"Hypnotoad" ]];
	
	expect(queue[0]).to.equal(@"Everybody Watch");
	expect(queue[1]).to.equal(@"Hypnotoad");
	
	queue[0] = @"Obey";
	expect(queue[0]).to.equal(@"Obey");
});

it(@"should call the eviction block when evicting objects from the queue", ^{
	CWFixedQueue *queue = [CWFixedQueue new];
	queue.capacity = 2;
	
	__block BOOL everybodyWatchTrigger = NO;
	__block BOOL hypnotoadTrigger = NO;
	queue.evictionBlock = ^(id object) {
		if([(NSString *)object isEqualToString:@"Everybody Watch"]){
			everybodyWatchTrigger = YES;
		} else if([(NSString *)object isEqualToString:@"Hypnotoad"]){
			hypnotoadTrigger = YES;
		}
	};
	
	//should be at capacity
	[queue enqueueObjectsInArray:@[ @"Everybody Watch",@"Hypnotoad" ]];
	
	//overflow the queue by 2
	[queue enqueueObjectsInArray:@[ @"Bite my shiny metal ass", @"Im gonna get my own theme park" ]];
	
	expect(everybodyWatchTrigger).to.beTruthy();
	expect(hypnotoadTrigger).to.beTruthy();
});

describe(@"enumeration operations", ^{
	CWFixedQueue *queue = [CWFixedQueue new];
	queue.capacity = 2;
	[queue enqueueObjectsInArray:@[ @"Everybody Watch",@"Hypnotoad" ]];
	
	it(@"should enumerate contents in the order expected forward", ^{
		//test forward
		__block NSUInteger count = 0;
		[queue enumerateContents:^(id object, NSUInteger index, BOOL *stop) {
			if (count == 0) {
				expect(object).to.equal(@"Everybody Watch");
			} else if (count == 1) {
				expect(object).to.equal(@"Hypnotoad");
			} else {
				STFail(@"Enumerated past expected bounds");
			}
			++count;
		}];
	});
	
	it(@"should be able to enumerate contents concurrently", ^{
		__block int32_t count = 0;
		[queue enumerateContentsWithOptions:NSEnumerationConcurrent usingBlock:^(id object, NSUInteger index, BOOL *stop) {
			if (count == 0) {
				expect(object).to.equal(@"Everybody Watch");
			} else if (count == 1) {
				expect(object).to.equal(@"Hypnotoad");
			} else {
				STFail(@"Enumerated past expected bounds");
			}
			OSAtomicIncrement32(&count);
		}];
	});
	
	it(@"should be able to enumerate in reverse", ^{
		__block NSUInteger count = 0;
		[queue enumerateContentsWithOptions:NSEnumerationReverse usingBlock:^(id object, NSUInteger index, BOOL *stop) {
			if (count == 1) {
				expect(object).to.equal(@"Everybody Watch");
			} else if (count == 0) {
				expect(object).to.equal(@"Hypnotoad");
			} else {
				STFail(@"Enumerated past expected bounds");
			}
			++count;
		}];
	});
});

SpecEnd
