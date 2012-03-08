/*
//  CWQueue.h
//  Zangetsu
//
//  Created by Colin Wheeler on 10/29/11.
//  Copyright (c) 2011. All rights reserved.
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
 
#import <Foundation/Foundation.h>

@interface CWQueue : NSObject
//Init
-(id)initWithObjectsFromArray:(NSArray *)array;
//Add Objects
-(void)addObject:(id)object;
-(void)addObjectsFromArray:(NSArray *)objects;
//Dequeue/Remove Objects
-(id)dequeueTopObject;
-(void)removeAllObjects;
-(void)dequeueOueueWithBlock:(void(^)(id object, BOOL *stop))block;
-(void)dequeueToObject:(id)targetObject withBlock:(void(^)(id object))block;
//Enumeration
-(void)enumerateObjectsInQueue:(void(^)(id object))block;
//Query
-(BOOL)containsObject:(id)object;
-(BOOL)containsObjectWithBlock:(BOOL (^)(id obj))block;
-(id)objectInFrontOf:(id)targetObject;
//Other Properties
-(NSUInteger)count;
//Equality
-(BOOL)isEqualToQueue:(CWQueue *)aQueue;
@end
