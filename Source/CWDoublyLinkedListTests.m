//
//  CWDoublyLinkedListTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/14/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "CWDoublyLinkedListTests.h"
#import "CWDoublyLinkedList.h"
#import "CWAssertionMacros.h"

@implementation CWDoublyLinkedListTests

-(void)testBasicDoublyLinkedList
{
	CWDoublyLinkedList *list = [[CWDoublyLinkedList alloc] init];
	
	[list addObject:@"Hello"];
	STAssertTrue(list.count == 1,@"count is incorrect");
	[list addObject:@"World"];
	STAssertTrue(list.count == 2,@"count is incorrect");
	
	CWAssertEqualsStrings([list objectAtIndex:0], @"Hello");
	CWAssertEqualsStrings([list objectAtIndex:1], @"World");
}

-(void)testInsertObject
{
	CWDoublyLinkedList *list = [[CWDoublyLinkedList alloc] init];
	
	STAssertTrue(list.count == 0,@"count is incorrect");
	[list addObject:@"Hello"];
	STAssertTrue(list.count == 1,@"count is incorrect");
	[list addObject:@"World"];
	STAssertTrue(list.count == 2,@"count is incorrect");
	
	[list insertObject:@"Hypnotoad" atIndex:1];
	STAssertTrue(list.count == 3,@"count is incorrect");
	
	CWAssertEqualsStrings([list objectAtIndex:0], @"Hello");
	CWAssertEqualsStrings([list objectAtIndex:1], @"Hypnotoad");
	CWAssertEqualsStrings([list objectAtIndex:2], @"World");
	
	//should basically do the equivalent of addObject
	[list insertObject:@"Super" atIndex:3];
	CWAssertEqualsStrings([list objectAtIndex:3], @"Super");
}

-(void)testRemoveObject
{
	CWDoublyLinkedList *list = [[CWDoublyLinkedList alloc] init];
	
	[list addObject:@"Fry"];
	[list addObject:@"Leela"];
	[list addObject:@"Bender"];
	[list addObject:@"Hypnotoad"];
	
	STAssertTrue(list.count == 4,@"Incorrect count");
	CWAssertEqualsStrings([list objectAtIndex:0], @"Fry");
	CWAssertEqualsStrings([list objectAtIndex:1], @"Leela");
	CWAssertEqualsStrings([list objectAtIndex:2], @"Bender");
	CWAssertEqualsStrings([list objectAtIndex:3], @"Hypnotoad");
	
	[list removeObject:@"Bender"];
	
	STAssertTrue(list.count == 3,@"Incorrect count");
	CWAssertEqualsStrings([list objectAtIndex:0], @"Fry");
	CWAssertEqualsStrings([list objectAtIndex:1], @"Leela");
	CWAssertEqualsStrings([list objectAtIndex:2], @"Hypnotoad");
	
	[list removeObjectAtIndex:1];
	
	STAssertTrue(list.count == 2,@"Incorrect count");
	CWAssertEqualsStrings([list objectAtIndex:0], @"Fry");
	CWAssertEqualsStrings([list objectAtIndex:1	], @"Hypnotoad");
}

-(void)testSwapObjects
{
	CWDoublyLinkedList *list = [CWDoublyLinkedList new];
	[list addObject:@"World!"];
	[list addObject:@"Hello"];
	
	CWAssertEqualsStrings([list objectAtIndex:0], @"World!");
	CWAssertEqualsStrings([list objectAtIndex:1], @"Hello");
	STAssertNil([list objectAtIndex:2], nil);
	
	[list swapObjectAtIndex:0 withIndex:1];
	
	CWAssertEqualsStrings([list objectAtIndex:0], @"Hello");
	CWAssertEqualsStrings([list objectAtIndex:1], @"World!");
	STAssertNil([list objectAtIndex:2], nil);
}

-(void)testEnumerateObjects
{
	CWDoublyLinkedList *list = [[CWDoublyLinkedList alloc] init];
	
	[list addObject:@"Fry"];
	[list addObject:@"Leela"];
	[list addObject:@"Bender"];
	[list addObject:@"Hypnotoad"];
	
	__block NSUInteger count = 0;
	[list enumerateObjectsWithBlock:^(id object, NSUInteger index, BOOL *stop) {
		count++;
		switch (index) {
			case 0:
				CWAssertEqualsStrings(object, @"Fry");
				break;
			case 1:
				CWAssertEqualsStrings(object, @"Leela");
				break;
			case 2:
				CWAssertEqualsStrings(object, @"Bender");
				break;
			case 3:
				CWAssertEqualsStrings(object, @"Hypnotoad");
				break;
			default:
				STFail(@"Oops we enumerated too far beyond the list bounds");
				break;
		}
	}];
	
	STAssertTrue(count == 4,@"oops something happened in enumeration");
}

-(void)testEnumerateInReverse
{
	CWDoublyLinkedList *list = [[CWDoublyLinkedList alloc] init];
	
	[list addObject:@"Fry"];
	[list addObject:@"Leela"];
	[list addObject:@"Bender"];
	[list addObject:@"Hypnotoad"];
	
	__block NSUInteger count = 0;
	// 1 = kCWDoublyLinkedListEnumerateReverse normally I wouldn't 
	// do this in real code for obvious reasons
	[list enumerateObjectsWithOption:1 usingBlock:^(id object, NSUInteger index, BOOL *stop) {
		count++;
		switch (index) {
			case 0:
				CWAssertEqualsStrings(object, @"Fry");
				break;
			case 1:
				CWAssertEqualsStrings(object, @"Leela");
				break;
			case 2:
				CWAssertEqualsStrings(object, @"Bender");
				break;
			case 3:
				CWAssertEqualsStrings(object, @"Hypnotoad");
				break;
			default:
				STFail(@"Oops we enumerated too far beyond the list bounds");
				break;
		}
	}];
	
	STAssertTrue(count == 4,@"oops something happened in enumeration");
}

-(void)testListWithRange
{
	CWDoublyLinkedList *list = [[CWDoublyLinkedList alloc] init];
	
	[list addObject:@"Fry"];
	[list addObject:@"Leela"];
	[list addObject:@"Bender"];
	[list addObject:@"Hypnotoad"];
	
	CWDoublyLinkedList *rangedList = [list linkedListWithRange:NSMakeRange(1, 2)];
	
	STAssertTrue(rangedList.count == 2,@"incorrect count");
	CWAssertEqualsStrings([rangedList objectAtIndex:0], @"Leela");
	CWAssertEqualsStrings([rangedList objectAtIndex:1], @"Bender");
	STAssertNil([rangedList objectAtIndex:2],@"shouldn't have a valid object here");
}

-(void)testCountIncrementsUsingInsertObjectAtIndex
{
	CWDoublyLinkedList *list = [CWDoublyLinkedList new];
	
	[list addObject:@5];
	[list addObject:@10];
	[list addObject:@42];
	
	STAssertTrue([list count] == 3, nil);
	
	[list insertObject:@9 atIndex:1];
	
	STAssertTrue([list count] == 4, nil);
	
	[list enumerateObjectsWithBlock:^(id object, NSUInteger index, BOOL *stop) {
		NSNumber *num = (NSNumber *)object;
		switch (index) {
			case 0:
				STAssertTrue([num integerValue] == 5, nil);
				break;
			case 1:
				STAssertTrue([num integerValue] == 9, nil);
				break;
			case 2:
				STAssertTrue([num integerValue] == 10, nil);
				break;
			case 3:
				STAssertTrue([num integerValue] == 42, nil);
				break;
			default:
				STFail(@"List is hitting an index out of bounds");
				break;
		}
	}];
}

-(void)testObjectSubscripting
{
	CWDoublyLinkedList *list = [CWDoublyLinkedList new];
	[list addObject:@"Everybody Watch"];
	[list addObject:@"Hypnotoad"];
	
	CWAssertEqualsStrings(@"Everybody Watch", list[0]);
	CWAssertEqualsStrings(@"Hypnotoad", list[1]);
	
	list[0] = @"Obey";
	CWAssertEqualsStrings(@"Obey", list[0]);
}

@end
