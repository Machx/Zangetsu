/*
//  NSURL+CWURLAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 7/21/12.
//  Copyright (c) 2012. All rights reserved.
//
 
 */

#import "NSURLAdditions.h"

@implementation NSURL (CWURLAdditions)

-(NSString *)cw_betterDescription
{
	NSMutableString *urlDescription = [[NSMutableString alloc] init];
	
#define CWURLLogAppendValue(_x_) do { \
			id obj = [self cw_ARCPerformSelector:NSSelectorFromString(_x_)]; \
			if(obj) { \
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
