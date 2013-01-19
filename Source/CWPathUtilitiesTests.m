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
#import "CWAssertionMacros.h"

@implementation CWPathUtilitiesTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

-(void)testAppendHomePath
{
    NSString *homePath1 = [@"~/Documents/Test" stringByExpandingTildeInPath];
    NSString *homePath2 = [CWPathUtilities pathByAppendingHomeFolderPath:@"Documents/Test"];
	
	CWAssertEqualsStrings(homePath1, homePath2);
}

-(void)testDocumentFolderPath
{
    NSString *documentPath1 = [@"~/Documents/Test.txt" stringByExpandingTildeInPath];
    NSString *documentPath2 = [CWPathUtilities documentsFolderPathForFile:@"Test.txt"];
    
	CWAssertEqualsStrings(documentPath1, documentPath2);
}

-(void)testExpandTildeFunction
{
	STAssertNil(CWFullPathFromTildeString(@"~/Quizzyjimbo1135599887658-111765"), @"This directory shouldn't exist");
	STAssertNotNil(CWFullPathFromTildeString(@"~/Documents"), @"Documents folder should be present on all installs");
}

-(void)testTemporaryPath
{
	NSString *path1 = [CWPathUtilities temporaryFilePath];
	NSString *path2 = [CWPathUtilities temporaryFilePath];
	NSString *path3 = [CWPathUtilities temporaryFilePath];
	
	CWAssertNotEqualsObjects(path1, path2, @"Paths should not be the same");
	CWAssertNotEqualsObjects(path1, path3, @"Paths should not be the same");
	CWAssertNotEqualsObjects(path2, path3, @"Paths should not be the same");
}

- (void)tearDown {
    // Tear-down code here.
    
    [super tearDown];
}

@end
