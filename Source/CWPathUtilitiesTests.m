/*
//  CWPathUtilitiesTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 6/28/11.
//  Copyright 2012. All rights reserved.
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

#import "CWPathUtilitiesTests.h"
#import "CWPathUtilities.h"

SpecBegin(CWPathUtilities)

describe(@"+pathByAppendingHomeFolderPath", ^{
	it(@"should correctly get the home folder path & append a value to it", ^{
		NSString *homePath1 = [@"~/Documents/Test" stringByExpandingTildeInPath];
		NSString *homePath2 = [CWPathUtilities pathByAppendingHomeFolderPath:@"Documents/Test"];
		
		expect(homePath1).to.equal(homePath2);
	});
});

describe(@"+documentsFolderPathForFile", ^{
	it(@"should correctly return the expected path in the Documents folder", ^{
		NSString *documentPath1 = [@"~/Documents/Test.txt" stringByExpandingTildeInPath];
		NSString *documentPath2 = [CWPathUtilities documentsFolderPathForFile:@"Test.txt"];
		
		expect(documentPath1).to.equal(documentPath2);
	});
});

describe(@"CWFullPathFromTildeString", ^{
	it(@"should return a non nil path for a valid path", ^{
		expect(CWFullPathFromTildeString(@"~/Documents")).notTo.beNil();
	});
	
	it(@"should return nil for invalid paths", ^{
		expect(CWFullPathFromTildeString(@"~/Quizzyjimbo1135599887658-111765")).to.beNil();
	});
});

describe(@"+temporaryFilePath", ^{
	it(@"should always return a unique temporary path", ^{
		NSString *path1 = [CWPathUtilities temporaryFilePath];
		NSString *path2 = [CWPathUtilities temporaryFilePath];
		NSString *path3 = [CWPathUtilities temporaryFilePath];
		
		expect(path1).notTo.equal(path2);
		expect(path1).notTo.equal(path3);
		expect(path2).notTo.equal(path3);
	});
});

SpecEnd
