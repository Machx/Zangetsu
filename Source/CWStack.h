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

-(id)topOfStackObject;

@end
