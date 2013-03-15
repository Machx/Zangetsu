/*
//  CWNSStringTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/5/10.
//  Copyright 2010. All rights reserved.
//
 	*/

#import "CWNSStringTests.h"
#import <Zangetsu/Zangetsu.h>

SpecBegin(CWNSStringAdditions)

describe(@"-cw_uuidString", ^{
	it(@"should never produce the same thing twice", ^{
		NSString *string1 = [NSString cw_uuidString];
		NSString *string2 = [NSString cw_uuidString];
		NSString *string3 = [NSString cw_uuidString];
		
		expect(string1).notTo.equal(string2);
		expect(string1).notTo.equal(string3);
		expect(string2).notTo.equal(string3);
	});
});

describe(@"-cw_isNotEmptyString", ^{
	it(@"should correctly detect an empty string", ^{
		NSString *emptyString = @"";
		expect([emptyString cw_isNotEmptyString]).to.beFalsy();
	});
	
	it(@"should correctly detect non empty strings", ^{
		NSString *testString = @"Fry";
		expect([testString cw_isNotEmptyString]).to.beTruthy();
	});
});

describe(@"-cw_escapeEntitiesForURL", ^{
	it(@"should escape all illegal characters", ^{
		NSString *urlCharsString = @"@!*'()[];:&=+$,/?%#";
		NSString *escapedString = [urlCharsString cw_escapeEntitiesForURL];
		NSCharacterSet *testIllegalCharSet = [NSCharacterSet characterSetWithCharactersInString:@"@!*'()[];:&=+$,/?#"];
		NSInteger location = [escapedString rangeOfCharacterFromSet:testIllegalCharSet].location;
		
		expect(location == NSNotFound).to.beTruthy();
	});
	
	it(@"should escape percent strings", ^{
		NSString *testCharString = @"%";
		NSString *escapedString = [testCharString cw_escapeEntitiesForURL];
		
		expect(escapedString).to.equal(@"%25");
	});
});

describe(@"-cw_enumerateConcurrentlyWithOptions:usingBlock:", ^{
	it(@"should enumerate all substrings", ^{
		NSString *string  = @"This\nis\na\nstring\nwith\nmany\nlines.";
		__block int32_t count = 0;
		[string cw_enumerateConcurrentlyWithOptions:NSStringEnumerationByLines usingBlock:^(NSString *substring) {
			OSAtomicIncrement32(&count);
		}];
		
		expect(count == 7).to.beTruthy();
	});
});

SpecEnd
