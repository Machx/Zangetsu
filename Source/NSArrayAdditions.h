/*
//  NSArrayAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler 
 
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

#import <Foundation/Foundation.h>


@interface NSArray (CWNSArrayAdditions)

/**
 Returns the 1st object in an array if it has count >= 1, otherwise returns nil
 
 @return object at index 0 if it exists, otherwise returns nil
 */
-(id)cw_firstObject;

/**
 Iterates over all the objects in an array and calls the block on each object
 
 This iterates over all the objects in an array calling the block on each object
 until it reaches the end of the array or until the BOOL *stop pointer is set to
 YES. This method was inspired by Ruby's each method and works very similarly to
 it, while at the same time staying close to existing ObjC standards for block 
 arguments which is why it passes a BOOL *stop pointer allowing you to signal 
 for enumeration to end.
 
 Important! If block is nil then this method will throw an exception.
 
 @param obj this is the object in the array currently being enumerated over
 @param index this is the index of obj in the array
 @param stop set this to YES to stop enumeration
 */
-(void) cw_each:(void (^)(id object, NSUInteger index, BOOL *stop))block;

/**
 Enumerates over the receiving arrays objects concurrently
 
 Enumerates over all the objects in the receiving array concurrently. That is it
 will go over each object and execute a block passing that object in the array 
 as a parameter in the block. This methods asynchronously executes a block for 
 all objects in the array but waits for all blocks to finish executing before 
 going on.
 
 @param index the position of the object in the array
 @param obj the object being enumerated over
 @param stop if you need to stop the enumeration set this to YES
 */
- (void) cw_eachConcurrentlyWithBlock:(void (^)(id object, NSUInteger index, BOOL * stop))block;

/**
 Returns the first object in the receiver which passes the block test
 
 This method enumerates over all the objects in the receiver starting at index 0
 until it reaches the end. If the block ever returns YES this method stops 
 enumerating and returns the object it is currently enumerating over. If the
 block never returns YES then this method simply returns nil.
 
 @param block the block to be executed for each object returning a BOOL
 @return the first object which is passed to the block, and it returns YES
 */
-(id)cw_findWithBlock:(BOOL (^)(id object))block;

/**
 Returns a BOOL if an object passing the block test is contained in the receiver
 
 @param block a block passing in the object to be inspected & returning a BOOL
 @return a BOOL indicating if an object passing the test is contained in 
 */
-(BOOL)cw_isObjectInArrayWithBlock:(BOOL (^)(id object))block;

#if Z_HOST_OS_IS_MAC_OS_X
/**
 Returns a NSHashTable with all the objects passing the block test
 
 like cw_find but instead uses NSHashTable to store weak pointers to all objects
 passing the test of the bool block
 
 @param block the block to be executed over every object for testing
 @return a NSHashTable with all object passing the block test
 */
-(NSHashTable *)cw_findAllIntoWeakRefsWithBlock:(BOOL (^)(id object))block;
#endif

/**
 Map objects in one array to another array
 
 cw_mapArray basically maps an array by enumerating over the array to be mapped
 and executes the block while passing in the object to map. You simply need to 
 either
 (1) return the object to be mapped in the new array or
 (2) return nil if you don't want to map the passed in object
 
 @param block a block in which you return an object to be mapped to a new array 
		or nil to not map it
 @return a new mapped array
 */
-(NSArray *)cw_mapArray:(id (^)(id object))block;

/**
 Returns an array of objects in the the receiver that pass the test (block)
 
 In this API you simply need to inspect objects in tbe block and return YES if
 the object passes your test. When you return YES the object is added to the
 array returned from this set, otherwise it is excluded.
 
 @param block the block to be invoked to determine if an object passes the test
 @return a NSArray of objects passing the test defined in the block
 */
-(NSArray *)cw_arrayOfObjectsPassingTest:(BOOL (^)(id obj))block;

@end
