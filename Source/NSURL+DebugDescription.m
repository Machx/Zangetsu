/*
//  NSURL+DebugDescription.h
//  Zangetsu
//
//  Created by Colin Wheeler on 7/21/12.
//  Copyright (c) 2012. All rights reserved.
//
 
 Copyright (c) 2013, Colin Wheeler
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 - Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "NSURL+DebugDescription.h"

@implementation NSURL (Zangetsu_NSURL_DebugDescription)

-(NSString *)cw_betterDescription {
	NSMutableString *urlDescription = [NSMutableString new];
#define CWURLLogAppendValue(_x_) do { \
			id obj = [self cw_ARCPerformSelector:NSSelectorFromString(_x_)]; \
			if (obj) { \
				[urlDescription appendFormat:@"%@: %@\n",_x_,obj]; } \
			} \
		while(0);
	CWURLLogAppendValue(@"absoluteString");
	CWURLLogAppendValue(@"absoluteURL");
	CWURLLogAppendValue(@"baseURL");
	CWURLLogAppendValue(@"fragment");
	CWURLLogAppendValue(@"host");
	CWURLLogAppendValue(@"lastPathComponent");
	CWURLLogAppendValue(@"parameterString");
	// user pass
	CWURLLogAppendValue(@"user");
	CWURLLogAppendValue(@"password");
	//
	CWURLLogAppendValue(@"path");
	CWURLLogAppendValue(@"pathComponents");
	CWURLLogAppendValue(@"pathExtension");
	CWURLLogAppendValue(@"port");
	CWURLLogAppendValue(@"query");
	CWURLLogAppendValue(@"relativePath");
	CWURLLogAppendValue(@"relativeString");
	CWURLLogAppendValue(@"resourceSpecifier");
	CWURLLogAppendValue(@"scheme");
	CWURLLogAppendValue(@"standardizedURL");
#undef CWURLLogAppendValue
	return urlDescription;
}

@end
