//
//  CWNSObjectAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/15/10.
//  Copyright 2010. All rights reserved.
//

#import "NSObjectAdditions.h"
#import <objc/runtime.h>

@interface NSObject(CWPrivateNSObjectAdditions)
-(void)_cw_blockInvokeCallBack;
@end


@implementation NSObject (CWNSObjectAdditions)

//MARK: -
//MARK: Objective-C Associated Objects

/**
 returns the value associated with a key
 */
-(id)cw_valueAssociatedWithKey:(void *)key
{
	return objc_getAssociatedObject(self, key);
}

/**
 Associates the value with a key using a strong reference
 */
-(void)cw_associateValue:(id)value withKey:(void *)key
{
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

/**
 Associates the value with a key using a weak reference
 */
-(void)cw_associateWeakValue:(id)value withKey:(void *)key
{
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

//MARK: -
//MARK: Exerimental Perform with Block Methods

/**
 Executes the passed in block after a specified delay time
 */
-(void)cw_performAfterDelay:(NSTimeInterval)delay withBlock:(ObjTimeBlock)block
{
	[block performSelector:@selector(_cw_blockInvokeCallBack) withObject:nil afterDelay:delay];
}

/**
 Private - Internal Implementation Method
 */
-(void)_cw_blockInvokeCallBack
{
	void (^block)(void) = (id)self;
	block();
}

//MARK: -
//MARK: Perform Selector Methods

/**
 Creates a NSInvocation operation with self as the target and the passed in selector and
 adds the operation to the passed in NSOperationQueue.
 */
-(void)cw_performSelector:(SEL)selector withObject:(id)obj onQueue:(NSOperationQueue *)queue
{
	NSParameterAssert(queue);

	NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:selector object:obj];

	[queue addOperation:op];
}

-(void)cw_performSelector:(SEL)selector withObject:(id)obj onGCDQueue:(dispatch_queue_t)queue
{
	dispatch_async(queue, ^{
		[self performSelector:selector withObject:obj afterDelay:0];
	});
}

/**
 gets a list of all registered classes with the objective-c runtime
 and then figures out which ones are descended from the current class
 and adds those to an array and returns them.
 
 @return a NSArray with strings of the classes that are direct subclasses of the current class of the object
 */
-(NSArray *)cw_directSubclasses
{
	NSMutableArray *array = nil;
	
	Class *classes = nil;
	int numClasses = 0;
	
	numClasses = objc_getClassList(NULL, 0);
	
	if (numClasses > 0) {
		classes = NSAllocateCollectable(sizeof(Class) * numClasses,0);
		
		if (classes) {
			numClasses = objc_getClassList(classes, numClasses);
			
			Class const selfClass = [self class];
			int count = numClasses;
			
			for (int index = 0; index < count; ++index) {
				
				Class currClass = class_getSuperclass(classes[index]);
				
				if (currClass == selfClass) {
					if (array == nil) { array = [[NSMutableArray alloc] init]; }
					[array addObject:NSStringFromClass(classes[index])];
				}
			}
		}
	}
	
	return array;
}

-(BOOL)cw_swizzleMethod:(SEL)originalSel withNewMethod:(SEL)newSel error:(NSError **)error
{	
	Method originalMethod = class_getInstanceMethod([self class],originalSel);
	if (!originalMethod) {
		if(*error){
			*error = CWCreateError(101, @"com.Zangetsu.NSObjectAdditions_objcMethodSwizzling", @"No Original Method to swizzle!");
		}
		return NO;
	}
	
	Method newMethod = class_getInstanceMethod([self class], newSel);
	if (!newMethod) {
		if (*error) {
			*error = CWCreateError(102, @"com.Zangetsu.NSObjectAdditions_objcMethodSwizzling", @"No New Method to swizzle!");
		}
		return NO;
	}
	
	method_exchangeImplementations(originalMethod, newMethod);
	
	return YES;
}

@end
