//
//  CWNSErrorTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 3/14/11.
//  Copyright 2011. All rights reserved.
//

#import "CWNSErrorTests.h"
#import "CWErrorUtilities.h"
#import "CWMacros.h"

@implementation CWNSErrorTests

/**
 Testing CWCreateError()
 tests to make sure that the values passed in to each NSError object is the same regardless 
 if a NSError is created with NSError -errorWithDomain:code:... or CWCreateError()
 */
-(void)testCreateError
{	
	NSError *error1 = CWCreateError(101, @"com.something.something", @"Some Message");
	
	NSError *error2 = [NSError errorWithDomain:@"com.something.something" code:101 userInfo:NSDICT(@"Some Message",NSLocalizedDescriptionKey)];
	
	STAssertTrue([error1 code] == [error2 code], @"Error 1 and 2 codes should be the same");
	STAssertTrue([[error1 domain] isEqualToString:[error2 domain]], @"Error1 and 2 domains should be the same");
	
	NSString *error1Message = [[error1 userInfo] valueForKey:NSLocalizedDescriptionKey];
	NSString *error2Message = [[error2 userInfo] valueForKey:NSLocalizedDescriptionKey];
	
	STAssertTrue([error1Message isEqualToString:error2Message], @"Error1 and Error2 Message should be the same");
    
    //testing the string format on this NSError method
    NSError *error3 = CWCreateError(101, @"com.something.something", @"Some %@",@"Message");
    
    NSString *error3Message = [[error3 userInfo] valueForKey:NSLocalizedDescriptionKey];
    
    STAssertTrue([error2Message isEqualToString:error3Message], @"Error Messages should be the same");
}

@end
