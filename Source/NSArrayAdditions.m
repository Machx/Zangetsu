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
- (id) cw_firstObject {
    return [(NSArray *) self objectAtIndex:0];
}

/**
 * Ruby inspired iterator for NSArray in Objective-C
 */
- (NSArray *) cw_each:(void (^)(id obj))block {
    for (id object in self) {
        block(object);
    }

    return self;
}

/**
 * Ruby Inspired Iterator for NSArray in Objective-C
 * like cw_each except this one also passes in the index
 */
- (NSArray *) cw_eachWithIndex:(void (^)(id obj, NSInteger index))block {
    NSInteger i = 0;

    for (id object in self) {
        block(object, i);
        i++;
    }

    return self;
}

/**
 * Experimental each method that runs concurrently
 */
- (NSArray *) cw_eachConcurrentlyWithBlock:(void (^)(id obj, BOOL * stop))block {
    dispatch_group_t group = dispatch_group_create();

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    __block BOOL _stop = NO;

    for (id object in self) {

        if (_stop == YES) {
            break;
        }

        dispatch_group_async(group, queue, ^{
			block (object, &_stop);
		});
    }

    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    dispatch_release(group);

    return self;
}

/**
 * Finds the first instance of the object that you indicate
 * via a block (returning a bool) you are looking for
 */
- (id) cw_findWithBlock:(BOOL (^)(id obj))block {
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
- (BOOL) cw_isObjectInArrayWithBlock:(BOOL (^)(id obj))block {
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
- (NSArray *) cw_findAllWithBlock:(BOOL (^)(id obj))block {
    NSMutableArray * results = [[NSMutableArray alloc] init];

    for (id obj in self) {
        if (block(obj)) {
            [results addObject:obj];
        }
    }

    return results;
}

/**
 * experimental method
 * like cw_find but instead uses NSHashTable to store weak pointers to
 * all objects passing the test of the bool block
 *
 * I don't particularly like this name but given objc's naming
 * structure this is as good as I can do for now
 */
- (NSHashTable *) cw_findAllIntoWeakRefsWithBlock:(BOOL (^)(id))block {
    NSHashTable * results = [NSHashTable hashTableWithWeakObjects];

    for (id obj in self) {
        if (block(obj)) {
            [results addObject:obj];
        }
    }

    return results;
}

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
- (NSArray *) cw_mapArray:(id (^)(id obj))block {
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
