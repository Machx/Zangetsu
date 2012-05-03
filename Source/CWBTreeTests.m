//
//  CWBTreeTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 4/30/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "CWBTreeTests.h"
#import "CWBTree.h"
#import "CWAssertionMacros.h"

#define CWNSINT(_x_) [NSNumber numberWithInt:_x_]

@implementation CWBTreeTests

-(void)testBasicBTreeSetAndFind
{
	CWBTree *btree = [[CWBTree alloc] init];
	
	[btree setObjectValue:@"World" forKey:@"Hello"];
	
	CWAssertEqualsStrings([btree objectValueForKey:@"Hello"], @"World");
}

-(void)testBasicBTreeEnumeration
{
	CWBTree *btree = [[CWBTree alloc] init];
	
	[btree setObjectValue:CWNSINT(1) forKey:@"1"];
	[btree setObjectValue:CWNSINT(2) forKey:@"2"];
	[btree setObjectValue:CWNSINT(3) forKey:@"3"];
	[btree setObjectValue:CWNSINT(4) forKey:@"4"];
	[btree setObjectValue:CWNSINT(5) forKey:@"5"];
	[btree setObjectValue:CWNSINT(6) forKey:@"6"];
	[btree setObjectValue:CWNSINT(7) forKey:@"7"];
	[btree setObjectValue:CWNSINT(8) forKey:@"8"];
	[btree setObjectValue:CWNSINT(9) forKey:@"9"];
	[btree setObjectValue:CWNSINT(10) forKey:@"10"];
	[btree setObjectValue:CWNSINT(11) forKey:@"11"];
	[btree setObjectValue:CWNSINT(12) forKey:@"12"];
	[btree setObjectValue:CWNSINT(13) forKey:@"13"];
	[btree setObjectValue:CWNSINT(14) forKey:@"14"];
	[btree setObjectValue:CWNSINT(15) forKey:@"15"];
	
	__block NSInteger total = 0;
	
	[btree enumerateOverObjectsWithBlock:^(id value, NSString *key, BOOL *stop) {
		total += [(NSNumber *)value intValue];
	}];
	
	STAssertTrue(total == 120,@"total should be correct if enumeratedcorrectly");
}

-(void)testRandomBTreeEnumeration
{
	CWBTree *btree = [[CWBTree alloc] init];
	
	[btree setObjectValue:CWNSINT(50) forKey:@"50"];
	[btree setObjectValue:CWNSINT(10) forKey:@"10"];
	[btree setObjectValue:CWNSINT(3) forKey:@"3"];
	[btree setObjectValue:CWNSINT(90) forKey:@"90"];
	[btree setObjectValue:CWNSINT(55) forKey:@"55"];
	[btree setObjectValue:CWNSINT(2) forKey:@"2"];
	[btree setObjectValue:CWNSINT(9) forKey:@"9"];
	[btree setObjectValue:CWNSINT(77) forKey:@"77"];
	[btree setObjectValue:CWNSINT(99) forKey:@"99"];
	[btree setObjectValue:CWNSINT(19) forKey:@"19"];
	[btree setObjectValue:CWNSINT(1) forKey:@"1"];
	[btree setObjectValue:CWNSINT(12) forKey:@"12"];
	[btree setObjectValue:CWNSINT(85) forKey:@"85"];
	[btree setObjectValue:CWNSINT(17) forKey:@"17"];
	
	__block NSUInteger total = 0;
	
	[btree enumerateOverObjectsWithBlock:^(id value, NSString *aKey, BOOL *stop) {
		total += [(NSNumber *)value intValue];
	}];
	
	STAssertTrue(total == 529,@"count is not correct");
}

-(void)testNilValueForNonExistantkey
{
	CWBTree *btree = [[CWBTree alloc] init];
	
	[btree setObjectValue:@"World" forKey:@"Hello"];
	
	STAssertNil([btree objectValueForKey:@"Foobar"],
				@"oops we returned an object for a key that doesn't exist");
}

#undef NSINT

@end
