/*
//  CWNSObjectAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/15/10.
//  Copyright 2010. All rights reserved.
//
 
 Copyright (c) 2012 Colin Wheeler
 
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

#import "NSObjectAdditions.h"
#import <objc/runtime.h>

@interface NSObject(CWPrivateNSObjectAdditions)
-(void)_cw_blockInvokeCallBack;
@end


@implementation NSObject (CWNSObjectAdditions)

#pragma mark - Objective-C Associated Objects

-(id)cw_valueAssociatedWithKey:(void *)key {
	return objc_getAssociatedObject(self, key);
}

-(void)cw_associateValue:(id)value
				  atomic:(BOOL)atomic
				 withKey:(void *)key {
	objc_AssociationPolicy policty = (atomic ? OBJC_ASSOCIATION_RETAIN : OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	objc_setAssociatedObject(self, key, value, policty);
}

-(void)cw_associateValueByCopy:(id)value
						atomic:(BOOL)atomic
					   withKey:(void *)key {
	objc_AssociationPolicy policy = (atomic ? OBJC_ASSOCIATION_COPY : OBJC_ASSOCIATION_COPY_NONATOMIC);
	objc_setAssociatedObject(self, key, value, policy);
}

-(void)cw_associateWeakValue:(id)value withKey:(void *)key {
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - Exerimental Perform with Block Methods

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
	NSParameterAssert(queue);
	NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self
																	 selector:selector
																	   object:obj];
	[queue addOperation:op];
}

-(void)cw_performSelector:(SEL)selector 
			   withObject:(id)obj 
			   onGCDQueue:(dispatch_queue_t)queue {
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

#pragma mark - Misc

-(BOOL)cw_isNotNil {
	return YES;
}

@end
