/*
//  CWNSDateTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 4/2/11.
//  Copyright 2011. All rights reserved.
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

#import "CWNSDateTests.h"
#import "NSDateAddtions.h"

@implementation CWNSDateTests

-(void)testDateByAddingMinutes {
	
	NSDate *now = [NSDate date];
	
	NSDate *minutesFromNow1 = [now cw_dateByAddingMinutes:3];
	NSDate *minutesFromNow2 = [now dateByAddingTimeInterval:180];
	
	STAssertTrue([minutesFromNow1 compare:minutesFromNow2] == NSOrderedSame, @"Dates should be the same");
}

-(void)testDateByAddingHours {
	
	NSDate *now = [NSDate date];
	
	NSDate *hourFromNow1 = [now cw_dateByAddingHours:2];
	NSDate *hourFromNow2 = [now dateByAddingTimeInterval:7200];
	
	STAssertTrue([hourFromNow1 compare:hourFromNow2] == NSOrderedSame, @"Dates should be the same");
}

-(void)testDateByAddingDays {
	
	NSDate *today = [NSDate date];
	
	NSDate *tomorrow = [today dateByAddingTimeInterval:86400];
	NSDate *tomorrow2 = [today cw_dateByAddingDays:1];
	
	STAssertTrue([tomorrow compare:tomorrow2] == NSOrderedSame, @"Dates should be the same");
}

@end
