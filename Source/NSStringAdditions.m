/*
//  NSStringAdditions.m
//  Zangetsu
//
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
	const char *queueLabel = CWUUIDCStringPrependedWithString(@"com.Zangetsu.NSString_");
	dispatch_queue_t queue = dispatch_queue_create(queueLabel, DISPATCH_QUEUE_CONCURRENT);
	
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

- (BOOL) cw_isNotEmptyString
{
	return ( [self length] > 0 );
}

@end
