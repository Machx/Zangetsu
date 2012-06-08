/*
//  CWDoublyLinkedList.h
//  Zangetsu
//
//  Created by Colin Wheeler on 5/11/12.
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

#define kCWDoublyLinkedListEnumerateForward 0
#define kCWDoublyLinkedListEnumerateReverse 1

@interface CWDoublyLinkedList : NSObject

/**
 Returns a count of how many objects are present in the receiver
 
 @return a NSUInteger with the receivers item count
 */
@property(readonly,assign) NSUInteger count;

/**
 Appends anObject to the end of the receiver
 
 This simply appends an object to the tail end of the receiver.
 If anObject is nil then this method simply does nothing.
 
 @praram an Object any valid Cocoa object
 */
-(void)addObject:(id)anObject;

/**
 Inserts an object at the specified index
 
 This method checks to make sure it has a valid Cocoa object, if it
 doesn't it simply returns right away. Then it checks the index to 
 see if its valid. It must be within the bounds of the receiver or
 at the very end. For example if you had a list with 3 objects in 
 it (0,1,2) and you said insert at index 3 this would be valid, in
 that case it would simply perform -addObject: and return. Otherwise
 this method inserts the object at the specified index.
 
 @param anObject any valid Cocoa object
 @param index a NSUInteger with a valid index
 */
-(void)insertObject:(id)anObject atIndex:(NSUInteger)index;

/**
 Removes the object at a specified index in the receiver
 
 First a check is done to see if the index is valid. If the index is 
 invalid then it checks to see if the list is empty. If either of these 
 true then the method immediately exits. Otherwise it goes to the 
 specified index and removes the node from the receiver.
 
 @param NSUInteger a valid index within the bounds of the receiver
 */
-(void)removeObjectAtIndex:(NSUInteger)index;

/**
 Removes the specified object from the receiver if found
 
 This method simple enumerates through the contents of the receiver and
 if it finds the object then it will remove it. Otherwise this will 
 enumerate through all objects in the receiver without finding anything
 and then exit.
 
 @param object any valid Cocoa object
 */
-(void)removeObject:(id)object;

/**
 Returns the object at a specified index in the receiver
 
 This method checks for the index being within the bounds of the receiver
 and if not then it immediately exits. Otherwise it enumerates to the 
 specified index and returns the object associated with that index.
 
 @param index a NSUInteger where you want the data associated with that slot in the receiver
 */
-(id)objectAtIndex:(NSUInteger)index;

/**
 Returns a new CWDoublyLinkedList with the range given in the receiver
 
 This method checks for a valid range. If the range is invalid then this
 method immediately exits. Otherwise it adds the node in the receiver to 
 a new list and returns that list.
 */
-(CWDoublyLinkedList *)linkedListWithRange:(NSRange)range;

/**
 Enumerates the contents of the receiver
 
 If the list is empty this method immediately exits. Otherwise this method
 then starts at the front of the list and enumerates through all nodes 
 until it reaches the end.
 
 @param object (block) the object being enumerated over
 @param index (block) the index of the object being enumerated over
 @param stop (block) a BOOL pointer which you can set to YES to stop enumeration
 */
-(void)enumerateObjectsWithBlock:(void(^)(id object,NSUInteger index, BOOL *stop))block;

-(void)enumerateObjectsWithOption:(NSUInteger)option usingBlock:(void (^)(id object, NSUInteger index, BOOL *stop))block;

@end
