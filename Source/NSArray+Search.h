/*
//  NSArrayAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler 
 
 Copyright (c) 2013, Colin Wheeler
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 - Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <Foundation/Foundation.h>


@interface NSArray (Zangetsu_NSArray_Search)

/**
 Returns the 1st object in an array if it has count >= 1, otherwise returns nil
 
 @return object at index 0 if it exists, otherwise returns nil
 */
-(id)cw_firstObject;

/**
 Returns a random object from the array
 
 If the receive is an empty array this will return nil.
 
 @return a random object contained in the receiver array
 */
-(id)cw_randomObject;


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
 Returns an array of objects in the the receiver that pass the test (block)
 
 In this API you simply need to inspect objects in tbe block and return YES if
 the object passes your test. When you return YES the object is added to the
 array returned from this set, otherwise it is excluded.
 
 @param block the block to be invoked to determine if an object passes the test
 @return a NSArray of objects passing the test defined in the block
 */
-(NSArray *)cw_arrayOfObjectsPassingTest:(BOOL (^)(id obj))block;

@end
