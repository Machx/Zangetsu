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
	[list addObject:@"World"];
	
	STAssertTrue(list.count == 2,@"count is incorrect");
	CWAssertEqualsStrings([list objectAtIndex:0], @"Hello");
	CWAssertEqualsStrings([list objectAtIndex:1], @"World");
}

-(void)testInsertObject
{
	CWDoublyLinkedList *list = [[CWDoublyLinkedList alloc] init];
	
	[list addObject:@"Hello"];
	[list addObject:@"World"];
	
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

@end
