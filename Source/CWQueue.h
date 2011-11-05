//
//  CWQueue.h
//  Zangetsu
//
//  Created by Colin Wheeler on 10/29/11.
//  Copyright (c) 2011. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWQueue : NSObject

-(id)initWithObjectsFromArray:(NSArray *)array;

-(void)addObject:(id)object;

-(void)addObjectsFromArray:(NSArray *)objects;

-(id)dequeueTopObject;

-(void)removeAllObjects;

-(void)enumerateObjectsInQueue:(void(^)(id object))block;

-(NSUInteger)count;

-(BOOL)isEqualToQueue:(CWQueue *)aQueue;

@end
