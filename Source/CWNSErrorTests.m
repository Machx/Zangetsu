/*
//  CWNSErrorTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 3/14/11.
//  Copyright 2012. All rights reserved.
//
 	*/

#import "CWNSErrorTests.h"
#import "CWErrorUtilities.h"
#import "CWMacros.h"
#import "CWAssertionMacros.h"

SpecBegin(NSErrorTests)

<<<<<<< HEAD
/**
 Testing CWCreateError()
 tests to make sure that the values passed in to each NSError object is the same regardless 
 if a NSError is created with NSError -errorWithDomain:code:... or CWCreateError()	*/
-(void)testCreateError
{	
	NSError *error1 = CWCreateError(@"com.something.something",101, @"Some Message");
=======
describe(@"CWCreateError()", ^{
	it(@"should create an NSError instance the same as Apples API", ^{
		NSError *error1 = CWCreateError(@"com.something.something",101, @"Some Message");
		NSError *error2 = [NSError errorWithDomain:@"com.something.something"
											  code:101
										  userInfo:@{ NSLocalizedDescriptionKey : @"Some Message" }];
		
		expect(error1.code == error2.code).to.beTruthy();
		expect(error1.domain).to.equal(error2.domain);
		
		NSString *error1Message = [error1 userInfo][NSLocalizedDescriptionKey];
		NSString *error2Message = [error2 userInfo][NSLocalizedDescriptionKey];
		
		expect(error1Message).to.equal(error2Message);
	});
>>>>>>> upstream/master
	
	it(@"should accept va args", ^{
		NSError *error = CWCreateError(@"com.something.something", 101, @"Some %@",@"Message");
		NSString *errorMessage = [error userInfo][NSLocalizedDescriptionKey];
		
		expect(errorMessage).to.equal(@"Some Message");
	});
});

describe(@"CWCreateErrorWithUserInfo()", ^{
	it(@"should store values that can be retrieved in the info dictionary", ^{
		NSError *error = CWCreateErrorWithUserInfo(@"com.something.something",
												   404,
												   @{ @"testKey" : @"Hypnotoad" },
												   @"I can't computer!");
		
		expect(error.userInfo[@"testKey"]).to.equal(@"Hypnotoad");
	});
});

describe(@"CWErrorTrap()", ^{
	it(@"should correctly set an NSError object on a NSError pointer", ^{
		NSUInteger i = 50;
		NSError *error;
		BOOL result = CWErrorTrap(i > 5, ^NSError *{
			return CWCreateError(@"com.Test.Test", 404, @"Less than 5");
		}, &error);
		
		expect(result).to.beTruthy();
		expect(error.domain).to.equal(@"com.Test.Test");
		expect(error.code == 404).to.beTruthy();
		expect(error.userInfo[NSLocalizedDescriptionKey]).to.equal(@"Less than 5");
	});
	
	it(@"should return YES condition was meet even when given nil for NSError", ^{
		BOOL result = CWErrorTrap(YES, ^NSError *{
			return nil;
		}, nil);
		
		expect(result).to.beTruthy();
	});
});

describe(@"CWErrorSet()", ^{
	it(@"should set an error on a NSError pointer", ^{
		NSError *error;
		
		CWErrorSet(@"com.Test.Test",
				   404,
				   @"This is a test",
				   &error);
		
		expect(error.domain).to.equal(@"com.Test.Test");
		expect(error.code == 404).to.beTruthy();
		expect(error.userInfo[NSLocalizedDescriptionKey]).to.equal(@"This is a test");
	});
	
	it(@"should work even with nil passed in", ^{
		//we don't check for anything and just call the method
		//if it throws an exception Specta will catch it...
		CWErrorSet(@"com.Test.Test",
				   404,
				   @"This is a test",
				   nil);
	});
});

describe(@"CWErrorSetV()", ^{
	it(@"should set an error on a NSError pointer", ^{
		NSError *error;
		
		CWErrorSetV(@"com.Test.Test",
					404,
					@"This is a test",
					@{ @"TestKey" : @"Hypnotoad" },
					&error);
		
		expect(error.domain).to.equal(@"com.Test.Test");
		expect(error.code == 404).to.beTruthy();
		expect(error.userInfo[NSLocalizedDescriptionKey]).to.equal(@"This is a test");
		expect(error.userInfo[@"TestKey"]).to.equal(@"Hypnotoad");
	});
	
	it(@"should work even with nil passed in", ^{
		//we don't check for anything and just call the method
		//if it throws an exception Specta will catch it...
		CWErrorSetV(@"com.Test.Test",
					404,
					@"This is a test",
					nil, //user info
					nil); //error
	});
});

SpecEnd
