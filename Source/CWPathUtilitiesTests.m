/*
//  CWPathUtilitiesTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 6/28/11.
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

#import "CWPathUtilitiesTests.h"
#import "CWPathUtilities.h"

@implementation CWPathUtilitiesTests

- (void)setUp {
    [super setUp];
    
    // Set-up code here.
}

-(void)testAppendHomePath {
    NSString *homePath1 = [@"~/Documents/Test" stringByExpandingTildeInPath];
    NSString *homePath2 = [CWPathUtilities pathByAppendingHomeFolderPath:@"Documents/Test"];
	
	STAssertEqualObjects(homePath1, homePath2, @"Paths should be equal");
}

-(void)testDocumentFolderPath {
    NSString *documentPath1 = [@"~/Documents/Test.txt" stringByExpandingTildeInPath];
    NSString *documentPath2 = [CWPathUtilities documentsFolderPathForFile:@"Test.txt"];
    
	STAssertEqualObjects(documentPath1, documentPath2, @"Paths should be equal");
}

-(void)testExpandTildeFunction {
	STAssertNil(CWFullPathFromTildeString(@"~/Quizzyjimbo1135599887658-111765"), @"This directory shouldn't exist");
	STAssertNotNil(CWFullPathFromTildeString(@"~/Documents"), @"Documents folder should be present on all installs");
}

-(void)testTemporaryPath {
	NSString *path1 = [CWPathUtilities temporaryFilePath];
	NSString *path2 = [CWPathUtilities temporaryFilePath];
	NSString *path3 = [CWPathUtilities temporaryFilePath];
	
	STAssertFalse([path1 isEqualToString:path2], @"Paths should not be the same");
	STAssertFalse([path1 isEqualToString:path3], @"Paths should not be the same");
	STAssertFalse([path2 isEqualToString:path3], @"Paths should not be the same");
}

- (void)tearDown {
    // Tear-down code here.
    
    [super tearDown];
}

@end
