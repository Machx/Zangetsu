/*
//  NSArrayAdditions.m
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

#import "NSArrayAdditions.h"


@implementation NSArray (CWNSArrayAdditions)

/**
 * Convenience Method to return the first object in
 * a NSArray
 */
- (id) cw_firstObject
{
    if ([self count] > 0) {
        return [self objectAtIndex:0];
    }
    return nil;
}

/**
 Iterates over all the objects in an array and calls the block on each object
 
 This iterates over all the objects in an array calling the block on each object
 until it reaches the end of the array or until the BOOL *stop pointer is set to YES.
 This method was inspired by Ruby's each method and works very similarly to it, while
 at the same time staying close to existing ObjC standards for block arguments which
 is why it passes a BOOL *stop pointer allowing you to signal for enumeration to end.
 
 Important! If block is nil then this method will throw an exception.
 
 @param obj (Block Parameter) this is the object in the array currently being enumerated over
 @param index (Block Parameter) this is the index of obj in the array
 @param stop (Block Parameter) set this to YES to stop enumeration, otherwise there is no need to use this
 */
- (void) cw_each:(void (^)(id obj, NSUInteger index, BOOL *stop))block
{
	NSUInteger i = 0;
	BOOL shouldStop = NO;
	
    for (id object in self) {
		if (shouldStop == YES) { break; }
        block(object,i++,&shouldStop);
    }
}

/**
 Enumerates over the receiving arrays objects concurrently in a synchronous method.
 
 Enumerates over all the objects in the receiving array concurrently. That is it will
 go over each object and execute a block passing that object in the array as a parameter 
 in the block. This methods asynchronously executes a block for all objects in the array
 but waits for all blocks to finish executing before going on.
 
 @param index (Block Parameter) the position of the object in the array
 @param obj (Block Parameter) the object being enumerated over
 @param stop (Block Parameter) if you need to stop the enumeration set this to YES otherwise do nothing
 */
- (void) cw_eachConcurrentlyWithBlock:(void (^)(NSInteger index, id obj, BOOL * stop))block
{
	//make sure we get a unique queue identifier
	const char *label = [[NSString stringWithFormat:@"com.Zangetsu.NSArray_%@",[NSString cw_uuidString]] UTF8String];
    dispatch_group_t group = dispatch_group_create();
	dispatch_queue_t queue = dispatch_queue_create(label, DISPATCH_QUEUE_CONCURRENT);
    __block BOOL _stop = NO;
    NSInteger idx = 0;

    for (id object in self) {
        if (_stop == YES) { break; }
        dispatch_group_async(group, queue, ^{
			block (idx,object, &_stop);
		});
        idx++;
    }

    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    dispatch_release(group);
	dispatch_release(queue);
}

/**
 * Finds the first instance of the object that you indicate
 * via a block (returning a bool) you are looking for
 */
- (id) cw_findWithBlock:(BOOL (^)(id obj))block
{
    for (id obj in self) {
        if (block(obj)) {
            return obj;
        }
    }
    return nil;
}

/**
 * Exactly like cw_findWithBlock except it returns a BOOL
 */
- (BOOL) cw_isObjectInArrayWithBlock:(BOOL (^)(id obj))block
{
    for (id obj in self) {
        if (block(obj)) {
            return YES;
        }
    }
    return NO;
}

/**
 * Like cw_find but instead of returning the first object
 * that passes the test it returns all objects passing the
 * bool block test
 */
- (NSArray *) cw_findAllWithBlock:(BOOL (^)(id obj))block
{
    NSMutableArray * results = [[NSMutableArray alloc] init];
    for (id obj in self) {
        if (block(obj)) {
            [results addObject:obj];
        }
    }
    return results;
}

#if !(TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
/**
 * experimental method
 * like cw_find but instead uses NSHashTable to store weak pointers to
 * all objects passing the test of the bool block
 *
 * I don't particularly like this name but given objc's naming
 * structure this is as good as I can do for now
 */
- (NSHashTable *) cw_findAllIntoWeakRefsWithBlock:(BOOL (^)(id))block
{
    NSHashTable * results = [NSHashTable hashTableWithWeakObjects];
    for (id obj in self) {
        if (block(obj)) {
            [results addObject:obj];
        }
    }
    return results;
}
#endif

/**
 * cw_mapArray basically maps an array by enumerating
 * over the array to be mapped and executes the block while
 * passing in the object to map. You simply need to either
 * (1) return the object to be mapped in the new array or
 * (2) return nil if you don't want to map the passed in object
 *
 * @param block a block in which you return an object to be mapped to a new array or nil to not map it
 * @return a new mapped array
 */
- (NSArray *) cw_mapArray:(id (^)(id obj))block
{
    NSMutableArray * cwArray = [[NSMutableArray alloc] init];
    for (id obj in self) {
        id rObj = block(obj);
        if (rObj) {
            [cwArray addObject:rObj];
        }
    }
    return cwArray;
}

@end
