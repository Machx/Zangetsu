//
//  CWNSStringTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/5/10.
//  Copyright 2010. All rights reserved.
//

#import "CWNSStringTests.h"
#import <Zangetsu/Zangetsu.h>

@implementation CWNSStringTests

-(void)testUUIDStrings
{
	NSString *string1 = [NSString cw_uuidString];
	NSString *string2 = [NSString cw_uuidString];
	
	STAssertTrue((![string1 isEqualToString:string2]),@"String 1 and String shouldn't be the same");
}

-(void)testEmptyStringMethod
{
	NSString *emptyString1 = @"";
	
	STAssertTrue(![emptyString1 cw_isNotEmptyString],@"String1 should be empty");
}

-(void)testURLEscaping
{
	NSCharacterSet *illegalURLCharsSet = [NSCharacterSet characterSetWithCharactersInString:@"@!*'()[];:&=+$,/?%#"];
	
	NSString *urlCharsString = [NSString stringWithString:@"@!*'()[];:&=+$,/?%#"];
	
	NSString *escapedString = [urlCharsString cw_escapeEntitiesForURL];
	
	NSInteger location = [escapedString rangeOfCharacterFromSet:illegalURLCharsSet].location;
	
	STAssertFalse(location == NSNotFound, @"chars in set shouldn't be found");
}

-(void)testEnumerateSubStrings {
    
    NSString *string  = [[NSString alloc] initWithString:@"This\nis\na\nstring\nwith\nmany\nlines."];
    
    __block NSInteger count = 0;
    
    [string cw_enumerateConcurrentlyWithOptions:NSEnumerationConcurrent usingBlock:^(NSString *substring) {
        count++;
    }];
    
    STAssertTrue(count == 7, @"Count should be 7");
}

@end
