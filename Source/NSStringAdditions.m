/*
//  NSStringAdditions.m
//  Zangetsu
//
 
 Copyright (c) 2011 Colin Wheeler
 
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

#import "NSStringAdditions.h"
#import <CoreFoundation/CoreFoundation.h>

@implementation NSString (CWNSStringAdditions)

+(NSString *)cw_uuidString
{
	CFUUIDRef uid = CFUUIDCreate(kCFAllocatorDefault);
	CFStringRef tmpString = CFUUIDCreateString(kCFAllocatorDefault, uid);
	CFRelease(uid);
	return (__bridge_transfer NSString *)tmpString;
}

- (void)cw_enumerateConcurrentlyWithOptions:(NSStringEnumerationOptions)options
                              usingBlock:(void (^)(NSString *substring))block
{
	//making sure we get a unique queue label
	dispatch_group_t group = dispatch_group_create();
	dispatch_queue_t queue = dispatch_queue_create(CWUUIDCStringPrependedWithString(@"com.Zangetsu.NSString_"), DISPATCH_QUEUE_CONCURRENT);
	
	[self enumerateSubstringsInRange:NSMakeRange(0, [self length])
							 options:options
						  usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclRange, BOOL *stop){
							  dispatch_group_async(group, queue, ^ {
								  block(substring);
							  });
	 }];
	
	dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
	dispatch_release(group);
	dispatch_release(queue);
}

-(NSString *)cw_escapeEntitiesForURL
{	
	CFStringRef str = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, NULL, CFSTR("@!*'()[];:&=+$,/?%#"), kCFStringEncodingUTF8);
	return (__bridge_transfer NSString *)str;
}

- (BOOL) cw_isNotEmptyString
{
	return ( [self length] > 0 );
}

@end
