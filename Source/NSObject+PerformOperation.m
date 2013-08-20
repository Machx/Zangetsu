//
//  NSObject+PerformOperation.m
//  Zangetsu
//
//  Created by Colin Wheeler on 8/20/13.
//
//

#import "NSObject+PerformOperation.h"

@interface NSObject(CWPrivateNSObjectAdditions)
-(void)_cw_blockInvokeCallBack;
@end

@implementation NSObject (Zangetsu_NSObject_PerformOperation)

-(void)cw_performAfterDelay:(NSTimeInterval)delay
				  withBlock:(dispatch_block_t)block {
	[block performSelector:@selector(_cw_blockInvokeCallBack)
				withObject:nil
				afterDelay:delay];
}

/**
 Private - Internal Implementation Method
 */
-(void)_cw_blockInvokeCallBack {
	dispatch_block_t block = (id)self;
	block();
}

#pragma mark - Perform Selector Methods

-(void)cw_performSelector:(SEL)selector
			   withObject:(id)obj
				  onQueue:(NSOperationQueue *)queue {
	CWAssert(queue != nil);
	NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self
																	 selector:selector
																	   object:obj];
	[queue addOperation:op];
}

-(void)cw_performSelector:(SEL)selector
			   withObject:(id)obj
			   onGCDQueue:(dispatch_queue_t)queue {
	CWAssert(queue != NULL);
	CWAssert(obj != nil);
	CWAssert(selector != NULL);
	dispatch_async(queue, ^{
		[self performSelector:selector
				   withObject:obj
				   afterDelay:0];
	});
}

-(id)cw_ARCPerformSelector:(SEL)selector {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
	return [self performSelector:selector];
#pragma clang diagnostic pop
}

@end
