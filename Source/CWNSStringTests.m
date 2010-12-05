//
//  CWNSStringTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
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

@end
