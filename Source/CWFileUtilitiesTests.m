//
//  CWFileUtilitiesTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 6/23/11.
//  Copyright 2011. All rights reserved.
//

#import "CWFileUtilitiesTests.h"
#import "CWFileUtilities.h"

@implementation CWFileUtilitiesTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

-(void)testTemporaryFilePath {
    
    NSString *path1 = [CWFileUtilities temporaryFilePath];
    NSString *path2 = [CWFileUtilities temporaryFilePath];
    
    STAssertFalse([path1 isEqualToString:path2], @"paths should not be the same");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
