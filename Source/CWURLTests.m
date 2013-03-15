/*
//  CWURLAdditionTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/22/11.
//  Copyright 2012. All rights reserved.
//
 	*/

#import "CWURLTests.h"
#import <Zangetsu/Zangetsu.h>

SpecBegin(CWNSURLAddition)

describe(@"CWURL()", ^{
	NSString * const kAppleURLString = @"http://www.apple.com";
	
	it(@"should produce a URL idental to one created by Cocoa API", ^{
		NSURL *appleURL = CWURL(kAppleURLString);
		NSURL *systemURL = [NSURL URLWithString:kAppleURLString];
		
		expect(appleURL).to.equal(systemURL);
	});
	
	it(@"should work with va arguments", ^{
		NSURL *appleURL2 = CWURL(@"%@/%@",kAppleURLString,@"macosx");
		NSString *urlString = [NSString stringWithFormat:@"%@/%@",kAppleURLString,@"macosx"];
		
		expect(appleURL2).to.equal([NSURL URLWithString:urlString]);
	});
});

SpecEnd
