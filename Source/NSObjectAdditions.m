/*
//  CWNSObjectAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/15/10.
//  Copyright 2010. All rights reserved.
//
 
 */

#import "NSObjectAdditions.h"
#import <objc/runtime.h>

@interface NSObject(CWPrivateNSObjectAdditions)
-(void)_cw_blockInvokeCallBack;
@end


@implementation NSObject (CWNSObjectAdditions)

#pragma mark - Objective-C Associated Objects

-(id)cw_valueAssociatedWithKey:(void *)key 
{
	return objc_getAssociatedObject(self, key);
}

-(void)cw_associateValue:(id)value withKey:(void *)key
{
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

-(void)cw_associateWeakValue:(id)value withKey:(void *)key
{
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - Exerimental Perform with Block Methods

-(void)cw_performAfterDelay:(NSTimeInterval)delay withBlock:(void (^)())block
{
	[block performSelector:@selector(_cw_blockInvokeCallBack) 
				withObject:nil 
				afterDelay:delay];
}

/**
 Private - Internal Implementation Method
 */
-(void)_cw_blockInvokeCallBack
{
	void (^block)(void) = (id)self;
	block();
}

#pragma mark - Perform Selector Methods

-(void)cw_performSelector:(SEL)selector 
			   withObject:(id)obj 
				  onQueue:(NSOperationQueue *)queue
{
	NSParameterAssert(queue);
	NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:selector object:obj];
	[queue addOperation:op];
}

-(void)cw_performSelector:(SEL)selector 
			   withObject:(id)obj 
			   onGCDQueue:(dispatch_queue_t)queue 
{
	dispatch_async(queue, ^{
		[self performSelector:selector 
				   withObject:obj 
				   afterDelay:0];
	});
}

-(id)cw_ARCPerformSelector:(SEL)selector
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
	return [self performSelector:selector];
#pragma clang diagnostic pop
}

#pragma mark - Misc

-(BOOL)cw_isNotNil
{
	return YES;
}

@end
