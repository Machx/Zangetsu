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

-(NSArray *)popToBottomOfStack;

-(id)topOfStackObject;

-(id)bottomOfStackObject;

-(void)clearStack;

@end
