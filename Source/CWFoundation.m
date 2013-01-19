/*
//  CWFoundation.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/16/10.
//  Copyright 2010. All rights reserved.
//

Copyright (c) 2012 Colin Wheeler

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

#import "CWFoundation.h"

BOOL CWClassExists(NSString * class)
{
	Class _class = NSClassFromString(class);
	return (_class) ? YES : NO;
}

NSString *CWBOOLString(BOOL value)
{
    return (value) ? @"YES" : @"NO";
}


NSString *CWUUIDStringPrependedWithString(NSString *preString)
{
	NSString *unqiueString = [NSString stringWithFormat:@"%@%@",preString,[NSString cw_uuidString]];
	return unqiueString;
}

const char *CWUUIDCStringPrependedWithString(NSString *preString)
{
	NSString *uString = CWUUIDStringPrependedWithString(preString);
	if (uString) {
		return [uString UTF8String];
	}
	return NULL;
}

void CWNextRunLoop(dispatch_block_t block)
{
	static dispatch_queue_t queue = nil;
	if (!queue) {
		const char *label = CWUUIDCStringPrependedWithString(@"com.Zangetsu.CWFoundation");
		queue = dispatch_queue_create(label, DISPATCH_QUEUE_SERIAL);
	}
	dispatch_async(queue, ^{
		dispatch_sync(dispatch_get_main_queue(), block);
	});
}

void CWPrintLine(NSArray *args)
{
	NSMutableString *printString = [[NSMutableString alloc] init];
	
	[args cw_each:^(id obj, NSUInteger index, BOOL *stop) {
		[printString appendFormat:@"%@ ",obj];
	}];
	
	NSLog(@"%@",printString);
}

void CWPrintfLine(NSArray *args)
{
	NSMutableString *printString = [[NSMutableString alloc] init];
	
	[args cw_each:^(id obj, NSUInteger index, BOOL *stop) {
		[printString appendFormat:@"%@ ",obj];
	}];
	
	printf("%s\n",[printString UTF8String]);
}
