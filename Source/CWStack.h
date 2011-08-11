//
//  CWStack.h
//  Zangetsu
//
//  Created by Colin Wheeler on 5/24/11.
//  Copyright 2011. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWStack : NSObject

-(id)initWithObjectsFromArray:(NSArray *)objects;

-(void)push:(id)object;

-(id)pop;

-(NSArray *)popToObject:(id)object;

-(void)popToObject:(id)object withBlock:(void (^)(id obj))block;

-(NSArray *)popToBottomOfStack;

-(id)topOfStackObject;

-(id)bottomOfStackObject;

-(void)clearStack;

-(BOOL)isEqualToStack:(CWStack *)aStack;

-(BOOL)isEmpty;

-(NSInteger)count;

@end
