//
//  NSStringAdditions.m
//  Zangetsu
//

#import "NSStringAdditions.h"


@implementation NSString (CWNSStringAdditions)

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

@end
