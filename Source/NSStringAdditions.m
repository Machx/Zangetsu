//
//  NSStringAdditions.m
//  Zangetsu
//

#import "NSStringAdditions.h"
#import <CoreFoundation/CoreFoundation.h>

@implementation NSString (CWNSStringAdditions)

/**
 Convenience method for Core Foundations CFUUIDCreate() function
 */
+(NSString *)cw_uuidString
{
	NSString *returnedString = nil;
	
	CFUUIDRef uid = CFUUIDCreate(kCFAllocatorDefault);
	returnedString = (NSString *)CFMakeCollectable(CFUUIDCreateString(kCFAllocatorDefault, uid));
	CFMakeCollectable(uid);
	
	return returnedString;
}

/**
 Asynchronous & Synchronous string enumeration 
 this method was created for being able to enumerate over all the lines
 in a string asychronously, but make the whole operation of enumerating 
 over all the lines, synchronous
 */
- (void)cw_enumerateConcurrentlyWithOptions:(NSStringEnumerationOptions)options
                              usingBlock:(void (^)(NSString *substring))block
{
	dispatch_group_t group = dispatch_group_create();
	
	[self enumerateSubstringsInRange:NSMakeRange(0, [self length])
							 options:options
						  usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclRange, BOOL *stop){
							  
							  dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^ {
								  block(substring);
							  });
	 }];
	
	dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}

/**
 NSString wrapper for the function CFXMLCreateStringByUnescapingEntities in Core Foundation
 */
- (NSString *) cw_stringByUnescapingEntities:(NSDictionary *)entitiesDictionary 
{
	CFStringRef str = CFXMLCreateStringByUnescapingEntities(NULL, (CFStringRef)self, (CFDictionaryRef) entitiesDictionary);
	
	NSString *returnString = [NSString stringWithString:(NSString *)str];
	
	CFMakeCollectable(str);
	
	return returnString;
}

/**
 NSString wrapper for the function CFURLCreateStringByAddingPercentEscapes in Core Foundation
 */
- (NSString *) cw_stringByAddingPercentEscapesUsingEncoding:(NSStringEncoding)encoding legalURLCharactersToBeEscaped:(NSString *)legalCharacters 
{
	CFStringRef str = CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, NULL, (CFStringRef)legalCharacters, CFStringConvertNSStringEncodingToEncoding(encoding));
	
	NSString *returnString = [NSString stringWithString:(NSString *)str];
	
	CFMakeCollectable(str);
	
	return returnString;
}

/**
 NSString wrapper for the function CFURLCreateStringByReplacingPercentEscapes in Core Foundation
 */
- (NSString *) cw_stringByReplacingPercentEscapes 
{
	CFStringRef str = CFURLCreateStringByReplacingPercentEscapes(NULL, (CFStringRef)self, CFMakeCollectable(CFSTR("")));
	
	NSString *returnString = [NSString stringWithString:(NSString *)str];
	
	CFMakeCollectable(str);
	
	return returnString;
}

@end
