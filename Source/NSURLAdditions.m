/*
//  NSURL+CWURLAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 7/21/12.
//  Copyright (c) 2012. All rights reserved.
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

#import "NSURLAdditions.h"

@implementation NSURL (CWURLAdditions)

/*
 We have to use clang diagnostics and ignore the warning that 
 clang generates here because I am using performSelector, in the
 future I will probably add something onto NSObject to deal with this.
 
 This is based on a method that does something very similar from Steve
 Streza, except his returns a NSDictionary and all I wanted was a NSString.
 */

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

-(NSString *)cw_betterDescription
{
	NSMutableString *urlDescription = [[NSMutableString alloc] init];
	
#define CWURLogAppendValue(_x_) do { id obj = [self performSelector:NSSelectorFromString(_x_)]; if(obj) { [urlDescription appendFormat:@"%@: %@\n",_x_,obj]; }} while(0);
	CWURLogAppendValue(@"absoluteString");
	CWURLogAppendValue(@"absoluteURL");
	CWURLogAppendValue(@"baseURL");
	CWURLogAppendValue(@"fragment");
	CWURLogAppendValue(@"host");
	CWURLogAppendValue(@"lastPathComponent");
	CWURLogAppendValue(@"parameterString");
	// user pass
	CWURLogAppendValue(@"user");
	CWURLogAppendValue(@"password");
	//
	CWURLogAppendValue(@"path");
	CWURLogAppendValue(@"pathComponents");
	CWURLogAppendValue(@"pathExtension");
	CWURLogAppendValue(@"port");
	CWURLogAppendValue(@"query");
	CWURLogAppendValue(@"relativePath");
	CWURLogAppendValue(@"relativeString");
	CWURLogAppendValue(@"resourceSpecifier");
	CWURLogAppendValue(@"scheme");
	CWURLogAppendValue(@"standardizedURL");
#undef CWURLogAppendValue
	return urlDescription;
}

@end

#pragma clang diagnostic pop
