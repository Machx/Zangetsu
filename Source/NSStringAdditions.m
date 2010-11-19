//
//  NSStringAdditions.m
//  Zangetsu
//

#import "NSStringAdditions.h"


@implementation NSString (CWNSStringAdditions)

//
// Asynchronous & Synchronous string enumeration 
// this method was created for being able to enumerate over all the lines
// in a string asychronously, but make the whole operation of enumerating 
// over all the lines, synchronous
//
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

//
//
//
- (NSString *) stringByUnescapingEntities:(NSDictionary *)entitiesDictionary 
{
	CFStringRef str = CFXMLCreateStringByUnescapingEntities(NULL,(CFStringRef) self,(CFDictionaryRef) entitiesDictionary);
	
	NSString *returnString = [NSString stringWithString:(NSString *)str];
	
	CFMakeCollectable(str);
	
	return returnString;
}

//
//
//
- (NSString *) stringByAddingPercentEscapesUsingEncoding:(NSStringEncoding)encoding legalURLCharactersToBeEscaped:(NSString *)legalCharacters 
{
	CFStringRef str = CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef) self, NULL, (CFStringRef)legalCharacters, CFStringConvertNSStringEncodingToEncoding(encoding));
	
	NSString *returnString = [NSString stringWithString:(NSString *)str];
	
	CFMakeCollectable(str);
	
	return returnString;
}

//
//
//
- (NSString *) stringByReplacingPercentEscapes 
{
	CFStringRef str = CFURLCreateStringByReplacingPercentEscapes(NULL, (CFStringRef) self, CFMakeCollectable(CFSTR("")));
	
	NSString *returnString = [NSString stringWithString:(NSString *)str];
	
	CFMakeCollectable(str);
	
	return returnString;
}

@end
