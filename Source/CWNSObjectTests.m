/*
//  CWNSObjectTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/18/10.
//  Copyright 2010. All rights reserved.
//
 	*/

#import "CWNSObjectTests.h"
#import "NSObjectAdditions.h"
#import "CWAssertionMacros.h"


@implementation CWNSObjectTests

/**
 Testing the strong associated reference to make sure it works	*/
-(void)testStrongReferenceObjcAssociation
{
	char *key1 = "key1";
	
	NSObject *object = [[NSObject alloc] init];
	
	[object cw_associateValue:@"All Hail the Hypnotoad" 
					  withKey:key1];
	
	CWAssertEqualsStrings([object cw_valueAssociatedWithKey:key1], @"All Hail the Hypnotoad");
}

-(void)testWeakObjcAssociation
{
	char *key3 = "key3";
	
	NSObject *object = [[NSObject alloc] init];
	
	[object cw_associateWeakValue:@"Hypnotoad Season 3"
						  withKey:key3];
	
	CWAssertEqualsStrings([object cw_valueAssociatedWithKey:key3], @"Hypnotoad Season 3");
}

-(void)testNotNil
{
	id object1 = nil;
	NSString *string = @"今日の天気がいいですね";
	
	STAssertFalse([object1 cw_isNotNil], nil);
	STAssertTrue([string cw_isNotNil], nil);
}

@end
