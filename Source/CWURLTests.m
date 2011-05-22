//
//  CWURLAdditionTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/22/11.
//  Copyright 2011. All rights reserved.
//

#import "CWURLTests.h"
#import <Zangetsu/Zangetsu.h>

static NSString * const kAppleURLString = @"http://www.apple.com";

@implementation CWURLAdditionTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

-(void)testCWURL {
	NSURL *appleURL = CWURL(kAppleURLString);
	
	STAssertTrue([appleURL isEqual:[NSURL URLWithString:kAppleURLString]], @"2 URL objects should have the same value");
}

-(void)testCWURLV {
	NSURL *appleURL2 = CWURL(@"%@/%@",kAppleURLString,@"macosx");
	
	NSString *urlString = [NSString stringWithFormat:@"%@/%@",kAppleURLString,@"macosx"];
	
	STAssertTrue([appleURL2 isEqual:[NSURL URLWithString:urlString]], @"2 URL objects should have the same value");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
