//
//  CWLinkedListTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 4/26/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "CWLinkedListTests.h"
#import "CWLinkedList.h"
#import "CWAssertionMacros.h"

@implementation CWLinkedListTests

-(void)testBasicLinkList
{
	CWLinkedList *list = [[CWLinkedList alloc] init];
	
	[list addObject:@"Hello"];
	
	STAssertNotNil([list objectAtIndex:0],@"Should contain an object");
	CWAssertEqualsStrings([list objectAtIndex:0], @"Hello");
	STAssertTrue(list.count == 1,@"count is incorrect");
	
	[list addObject:@"World"];
	
	STAssertNotNil([list objectAtIndex:1],@"Should contain an object");
	CWAssertEqualsStrings([list objectAtIndex:1], @"World");
	STAssertTrue(list.count == 2,@"count is incorrect");
	
	[list removeObjectAtIndex:0];
	STAssertTrue(list.count == 1,@"count is incorrect");
	CWAssertEqualsStrings([list objectAtIndex:0], @"World");
	
	[list removeObjectAtIndex:0];
	STAssertTrue(list.count == 0,@"count is incorrect");
}

-(void)testRemoveObject
{
	CWLinkedList *list = [[CWLinkedList alloc] init];
	
	[list addObject:@"Fry"];
	[list addObject:@"Leela"];
	[list addObject:@"Bender"];
	
	STAssertTrue(list.count == 3, @"list count is incorrect");
	
	[list removeObject:@"Bender"];
	
	STAssertTrue(list.count == 2, @"Should have 2 objects");
	CWAssertEqualsStrings([list objectAtIndex:0], @"Fry");
	CWAssertEqualsStrings([list objectAtIndex:1], @"Leela");
}

-(void)testEnumeration
{
	CWLinkedList *list = [[CWLinkedList alloc] init];
	
	[list addObject:@"Fry"];
	[list addObject:@"Leela"];
	[list addObject:@"Bender"];
	
	__block NSUInteger count = 0;
	
	[list enumerateObjectsWithBlock:^(id object, BOOL *stop) {
		switch (count) {
			case 0:
				CWAssertEqualsStrings(object, @"Fry");
				break;
			case 1:
				CWAssertEqualsStrings(object, @"Leela");
				break;
			case 2:
				CWAssertEqualsStrings(object, @"Bender");
				break;
			default:
				STFail(@"Beyond bounds");
				break;
		}
		count++;
	}];
	
	STAssertTrue(count == 3,@"Incorrect count");
	
	count = 0;
	
	[list enumerateObjectsWithBlock:^(id object, BOOL *stop) {
		count++;
		*stop = YES;
	}];
	
	STAssertTrue(count == 1,@"count should be 1");
}

@end
