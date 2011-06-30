//
//  CWPathUtilitiesTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 6/28/11.
//  Copyright 2011. All rights reserved.
//

#import "CWPathUtilitiesTests.h"
#import "CWPathUtilities.h"

@implementation CWPathUtilitiesTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

-(void)testAppendHomePath {
    
    NSString *homePath1 = [@"~/Documents/Test" stringByExpandingTildeInPath];
    NSString *homePath2 = [CWPathUtilities pathByAppendingHomeFolderPath:@"Documents/Test"];
     
    STAssertTrue([homePath1 isEqualToString:homePath2], @"paths should be equal");
}

-(void)testDocumentFolderPath {
    
    NSString *documentPath1 = [@"~/Documents/Test.txt" stringByExpandingTildeInPath];
    NSString *documentPath2 = [CWPathUtilities documentsFolderPathForFile:@"Test.txt"];
    
    STAssertTrue([documentPath1 isEqualToString:documentPath2], @"paths should be equal");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
