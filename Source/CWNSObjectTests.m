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

SpecBegin(CWNSObject)

describe(@"-cw_associateValue:withKey:", ^{
	it(@"should be able to store & retrieve strong references", ^{
		char *key1 = "key1";
		NSObject *object = [[NSObject alloc] init];
		[object cw_associateValue:@"All Hail the Hypnotoad"
						  withKey:key1];
		
		expect([object cw_valueAssociatedWithKey:key1]).to.equal(@"All Hail the Hypnotoad");
	});
});

<<<<<<< HEAD
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
=======
describe(@"cw_associateWeakValue:withKey:", ^{
	it(@"should be able to store & retrieve weak references", ^{
		char *key3 = "key3";
		NSObject *object = [[NSObject alloc] init];
		[object cw_associateWeakValue:@"Hypnotoad Season 3"
							  withKey:key3];
		
		expect([object cw_valueAssociatedWithKey:key3]).to.equal(@"Hypnotoad Season 3");
	});
});
>>>>>>> upstream/master

describe(@"-cw_isNotNil", ^{
	it(@"should correctly identify nil and non nil references", ^{
		id object1 = nil;
		NSString *string = @"今日の天気がいいですね";
		
		expect([object1 cw_isNotNil]).to.beFalsy();
		expect([string cw_isNotNil]).to.beTruthy();
	});
});

SpecEnd
