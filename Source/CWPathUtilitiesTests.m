/*
//  CWPathUtilitiesTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 6/28/11.
//  Copyright 2012. All rights reserved.
//
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
