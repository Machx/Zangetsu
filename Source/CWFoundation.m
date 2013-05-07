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

NSString *_CWPrintLineComposedString(NSArray *objects);

NSString *CWUUIDStringPrependedWithString(NSString *preString) {
	return [NSString stringWithFormat:@"%@%@",preString,[NSString cw_uuidString]];
}

NSString *_CWPrintLineComposedString(NSArray *objects) {
	NSMutableString *string = [NSMutableString string];
	for (id object in objects) {
		[string appendFormat:@"%@ ",object];
	}
	return string;
}

void CWPrintLine(NSArray *args) {
	NSLog(@"%@",_CWPrintLineComposedString(args));
}

void CWPrintfLine(NSArray *args) {
	printf("%s\n",[_CWPrintLineComposedString(args) UTF8String]);
}
