/*
//  CWLinkedList.h
//  Zangetsu
//
//  Created by Colin Wheeler on 4/26/12.
//  Copyright (c) 2012. All rights reserved.
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

#import <Foundation/Foundation.h>

//Exception Keys
static NSString * const kCWLinkedListInvalidRangeException = @"CWLinkedListInvalidRangeException";
static NSString * const kCWIndexKey = @"IndexArg";

@interface CWLinkedList : NSObject

/**
 Returns the number of objects stored in the receiver
 
 @return a NSUInteger with the number of objects stored in the receiver 
 */
@property(readonly,assign) NSUInteger count;

/**
 Appends the object to the end of the receiver storage
 
 @param any NSObject subclass, this must not be nil
 */
-(void)addObject:(id)anObject;

/**
 Inserts a given object at the index in the receiver
 
 This method inserts the given object into the index of the 
 receiver. The index must not be beyond the bounds of the 
 link list range because it will throw a 
 kCWLinkedListInvalidRangeException exception. 
 
 @param anObject any valid non nil object, otherwise this method returns immediately
 @param index an index within the bounds of the receiver for the object to be inserted at
 */
-(void)insertObject:(id)anObject atIndex:(NSUInteger)index;

/**
 Removes the object at a given index from the receiver
 
 If the index is beyond the bounds of the receiver then this throws
 a CWLinkedListInvalidRangeException. Otherwise this removes the
 object at the given index from the receiver
 
 @param NSUInteger the index of the object you want to be removed
 */
-(void)removeObjectAtIndex:(NSUInteger)index;

/**
 If present in the receiver array this method removes the object from the receiver
 
 @param object a NSObject subclass instance to be removed from the receiver. This must not be nil.
 */
-(void)removeObject:(id)object;

/**
 Returns the object at a given index of the receiver
 
 @pram index If this is beyond the bounds of the receiving object this throws a CWLinkedListInvalidRangeException exception
 @return the object at the index or nil if something went wrong
 */
-(id)objectAtIndex:(NSUInteger)index;

/**
 Enumerates over the contents of the Linked List
 
 @param id (block parameter) the object currently being enumerated over
 @param stop a BOOL pointer which you can set to YES to stop enumeration
 */
-(void)enumerateObjectsWithBlock:(void(^)(id object, BOOL *stop))block;

@end
