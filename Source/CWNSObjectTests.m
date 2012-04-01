/*
//  CWNSObjectTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/18/10.
//  Copyright 2010. All rights reserved.
//
 
 Copyright (c) 2011 Colin Wheeler
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "CWNSObjectTests.h"
#import "NSObjectAdditions.h"
#import "CWAssertionMacros.h"


@implementation CWNSObjectTests

/**
 Testing the strong associated reference to make sure it works
 */
-(void)testStrongReferenceObjcAssociation
{
	char *key1 = "key1";
	
	NSObject *object = [[NSObject alloc] init];
	
	[object cw_associateValue:@"All Hail the Hypnotoad" withKey:key1];
	
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

@end
