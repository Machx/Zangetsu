//
//  CWDoublyLinkedListTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/14/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "CWLinkedListTests.h"
#import "CWLinkedList.h"

SpecBegin(CWLinkedList)

it(@"should add objects to the linked list", ^{
	CWLinkedList *list = [[CWLinkedList alloc] init];
	
	expect(list.count == 0).to.beTruthy();
	
	[list addObject:@"Hello"];
	
	expect(list.count == 1).to.beTruthy();

	[list addObject:@"World"];
	
	expect(list.count == 2).to.beTruthy();
	expect(list[0]).to.equal(@"Hello");
	expect(list[1]).to.equal(@"World");
});

it(@"should be able to insert objects at indexes", ^{
	CWLinkedList *list = [[CWLinkedList alloc] init];
	
	expect(list.count == 0).to.beTruthy();
	
	[list addObject:@"Hello"];
	expect(list.count == 1).to.beTruthy();
	
	[list addObject:@"World"];
	expect(list.count == 2).to.beTruthy();
	
	[list insertObject:@"Hypnotoad" atIndex:1];
	expect(list.count == 3).to.beTruthy();
	expect(list[0]).to.equal(@"Hello");
	expect(list[1]).to.equal(@"Hypnotoad");
	expect(list[2]).to.equal(@"World");
	
	//should basically do the equivalent of addObject
	[list insertObject:@"Super"
			   atIndex:3];
	
	expect(list[3]).to.equal(@"Super");
});

it(@"should remove objects at indexes & by reference", ^{
	CWLinkedList *list = [[CWLinkedList alloc] init];
	[list addObject:@"Fry"];
	[list addObject:@"Leela"];
	[list addObject:@"Bender"];
	[list addObject:@"Hypnotoad"];
	
	expect(list.count == 4).to.beTruthy();
	expect(list[0]).to.equal(@"Fry");
	expect(list[1]).to.equal(@"Leela");
	expect(list[2]).to.equal(@"Bender");
	expect(list[3]).to.equal(@"Hypnotoad");
	
	[list removeObject:@"Bender"];
	
	expect(list.count == 3).to.beTruthy();
	expect(list[0]).to.equal(@"Fry");
	expect(list[1]).to.equal(@"Leela");
	expect(list[2]).to.equal(@"Hypnotoad");
	
	[list removeObjectAtIndex:1];
	
	expect(list.count == 2).to.beTruthy();
	expect(list[0]).to.equal(@"Fry");
	expect(list[1]).to.equal(@"Hypnotoad");
});

it(@"should be able to swap objects at indexes", ^{
	CWLinkedList *list = [CWLinkedList new];
	[list addObject:@"World!"];
	[list addObject:@"Hello"];
	
	expect(list.count == 2).to.beTruthy();
	expect(list[0]).to.equal(@"World!");
	expect(list[1]).to.equal(@"Hello");
	
	[list swapObjectAtIndex:0 withIndex:1];
	
	expect(list.count == 2).to.beTruthy();
	expect(list[0]).to.equal(@"Hello");
	expect(list[1]).to.equal(@"World!");
});

describe(@"list enumeration", ^{
	it(@"should be able to enumerate its contents", ^{
		CWLinkedList *list = [[CWLinkedList alloc] init];
		[list addObject:@"Fry"];
		[list addObject:@"Leela"];
		[list addObject:@"Bender"];
		[list addObject:@"Hypnotoad"];
		
		__block NSUInteger count = 0;
		[list enumerateObjectsWithBlock:^(id object, NSUInteger index, BOOL *stop) {
			count++;
			if (index == 0) {
				expect(object).to.equal(@"Fry");
				expect(count == 1).to.beTruthy();
			} else if (index == 1) {
				expect(count == 2).to.beTruthy();
				expect(object).to.equal(@"Leela");
			} else if (index == 2) {
				expect(count == 3).to.beTruthy();
				expect(object).to.equal(@"Bender");
			} else if (index == 3) {
				expect(count == 4).to.beTruthy();
				expect(object).to.equal(@"Hypnotoad");
			} else {
				STFail(@"Oops! we enumerated past our bounds?");
			}
		}];
		
		expect(count == 4).to.beTruthy();
	});
	
	it(@"should be able to enumerate in reverse", ^{
		CWLinkedList *list = [[CWLinkedList alloc] init];
		[list addObject:@"Fry"];
		[list addObject:@"Leela"];
		[list addObject:@"Bender"];
		[list addObject:@"Hypnotoad"];
		__block NSUInteger count = 0;
		[list enumerateObjectsWithOption:kCWDoublyLinkedListEnumerateReverse usingBlock:^(id object, NSUInteger index, BOOL *stop) {
			count++;
			//test based on count value rather than index
			//to make sure we counter objects in the
			//order that we expect
			if (count == 1) {
				expect(object).to.equal(@"Hypnotoad");
				expect(index == 3).to.beTruthy();
			} else if (count == 2) {
				expect(object).to.equal(@"Bender");
				expect(index == 2).to.beTruthy();
			} else if (count == 3) {
				expect(object).to.equal(@"Leela");
				expect(index == 1).to.beTruthy();
			} else if (count == 4) {
				expect(object).to.equal(@"Fry");
				expect(index == 0).to.beTruthy();
			} else {
				STFail(@"Opps! we enumerated past our bounds");
			}
		}];
		expect(count == 4).to.beTruthy();
	});
});

it(@"should create a list with a given range", ^{
	CWLinkedList *list = [[CWLinkedList alloc] init];
	[list addObject:@"Fry"];
	[list addObject:@"Leela"];
	[list addObject:@"Bender"];
	[list addObject:@"Hypnotoad"];
	
	CWLinkedList *rangedList = [list linkedListWithRange:NSMakeRange(1, 2)];
	
	expect(rangedList.count == 2).to.beTruthy();
	expect(rangedList[0]).to.equal(@"Leela");
	expect(rangedList[1]).to.equal(@"Bender");
	expect(rangedList[2]).to.beNil();
});

it(@"should work with object subscripting", ^{
	CWLinkedList *list = [CWLinkedList new];
	[list addObject:@"Everybody Watch"];
	[list addObject:@"Hypnotoad"];
	
	expect(list[0]).to.equal(@"Everybody Watch");
	expect(list[1]).to.equal(@"Hypnotoad");
	
	list[0] = @"Obey";
	
	expect(list[0]).to.equal(@"Obey");
	expect(list[1]).to.equal(@"Hypnotoad");
});

SpecEnd
