/*
//  NSMutableArrayAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 8/26/11.
//  Copyright 2012. All rights reserved.
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

static NSString * const kCWNSMutableArrayAdditionsErrorDomain = @"com.Zangetsu.NSMutableArrayAdditions";

static NSUInteger const kCWNSMutableArrayAdditionsObjectNotFoundCode = 404;

@interface NSMutableArray (CWNSMutableArrayAdditions)

/**
 adds objects from another array to the receiver by copying the objects
 
 adds the objects from otherArray to the receiver by sending the copy message
 to each object before adding it to the receivers array.
 
 @param otherArray an NSArray whose contents should be copied into the receiver
 */
-(void)cw_addObjectsFromArrayByCopying:(NSArray *)otherArray;

/**
 Moves the object at whatever index it is at to the specified index
 
 @param object in the receiver you want to move to a new index
 @param index the index you wish to move the specified object to
 */
-(void)cw_moveObject:(id)object
			 toIndex:(NSUInteger)index;

@end
