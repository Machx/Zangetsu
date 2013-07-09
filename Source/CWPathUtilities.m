/*
//  CWPathUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/20/10.
//  Copyright 2010. All rights reserved.
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

#import "CWPathUtilities.h"

static NSString * const kCWAppName = @"CFBundleName";


NSString *CWFullPathFromTildeString(NSString *tildePath) {
	if (tildePath == nil) {
		CWLogInfo(@"tildePath argument is nil, returning nil...");
		return nil;
	}
	NSString *path = [tildePath stringByExpandingTildeInPath];
	if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
		return path;
	}
	return nil;
}

@implementation CWPathUtilities

+ (NSString *) applicationSupportFolder {
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) cw_firstObject];
    if (path) {
		NSString * appName = [[[NSBundle mainBundle] infoDictionary] valueForKey:kCWAppName];
		return [NSString stringWithFormat:@"%@/%@", path, appName];
	}
	return nil;
}

+ (NSString *) documentsFolderPathForFile:(NSString *)file {
    NSString *path = nil;
    path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) cw_firstObject];
    if (path) {
		return [NSString stringWithFormat:@"%@/%@",path,file];
	}
	return nil;
}

+ (NSString *) pathByAppendingAppSupportFolderWithPath:(NSString *)path {
    NSString * appSupportPath = [CWPathUtilities applicationSupportFolder];
	if (appSupportPath) {
		return [NSString stringWithFormat:@"%@/%@", appSupportPath, path];
	}
    return nil;
}

+ (NSString *) pathByAppendingHomeFolderPath:(NSString *)subPath {
	return [NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),subPath];
}

+(NSString *)temporaryFilePath {
	return [NSString stringWithFormat:@"%@%@.temp", NSTemporaryDirectory(), [NSString cw_uuidString]];
}

@end
