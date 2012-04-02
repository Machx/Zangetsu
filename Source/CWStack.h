/*
//  CWStack.h
//  Zangetsu
//
//  Created by Colin Wheeler on 5/24/11.
//  Copyright 2011. All rights reserved.
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

@interface CWStack : NSObject
-(id)initWithObjectsFromArray:(NSArray *)objects;
// Push & Pop
-(void)push:(id)object;
-(id)pop;
-(NSArray *)popToObject:(id)object;
-(void)popToObject:(id)object withBlock:(void (^)(id obj))block;
-(NSArray *)popToBottomOfStack;
// Top & Bottom Objects
-(id)topOfStackObject;
-(id)bottomOfStackObject;
//Stack Operations
-(void)clearStack;
//Equality
-(BOOL)isEqualToStack:(CWStack *)aStack;
//Querying the Stack
-(BOOL)containsObject:(id)object;
-(BOOL)containsObjectWithBlock:(BOOL (^)(id object))block;
//Other Properties
-(BOOL)isEmpty;
-(NSInteger)count;
@end
