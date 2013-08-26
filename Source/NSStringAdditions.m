/*
//  NSStringAdditions.m
//  Zangetsu
//
 
 Copyright (c) 2013, Colin Wheeler
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 - Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "NSStringAdditions.h"
#import <CoreFoundation/CoreFoundation.h>



@implementation NSString (CWNSStringAdditions)

- (void)cw_enumerateConcurrentlyWithOptions:(NSStringEnumerationOptions)options
								  withBlock:(void (^)(NSString *substring))block {
	dispatch_group_t group = dispatch_group_create();
	const char *queueLabel = [CWUUIDStringPrependedWithString(@"com.Zangetsu.NSString_") UTF8String];
	dispatch_queue_t queue = dispatch_queue_create(queueLabel, DISPATCH_QUEUE_CONCURRENT);
	
	[self enumerateSubstringsInRange:NSMakeRange(0,self.length)
							 options:options
						  usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclRange, BOOL *stop){
		dispatch_group_async(group, queue, ^{
			block(substring);
		});
	}];
	
	dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
	dispatch_release(group); group = nil;
	dispatch_release(queue); queue = nil;
}

-(NSString *)cw_escapeEntitiesForURL {
	NSMutableString *escapedString = [NSMutableString string];
	const char *originalString = [self UTF8String];
	while (*originalString) {
		const unsigned char currentChar = *originalString;
		if((( currentChar >= 'a' ) && ( currentChar <= 'z' )) ||
		   (( currentChar >= 'A' ) && ( currentChar <= 'Z' )) ||
		   (( currentChar >= '0' ) && ( currentChar <= '9' )) ||
		   (  currentChar == '.' ) ||
		   (  currentChar == '~' ) ||
		   (  currentChar == '_' ) ||
		   (  currentChar == '-' ) ){
			[escapedString appendFormat:@"%c",currentChar];
		} else if (currentChar == ' ') {
			[escapedString appendString:@"%20"];
		} else  {
			[escapedString appendFormat:@"%%%02X",currentChar];
		}
		originalString++;
	}
	return escapedString;
}

- (BOOL) cw_isNotEmptyString {
	return (self.length > 0);
}

@end
