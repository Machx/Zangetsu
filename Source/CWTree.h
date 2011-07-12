//
//  CWTree.h
//  Zangetsu
//
//  Created by Colin Wheeler on 7/12/11.
//  Copyright 2011. All rights reserved.
//

#import <Foundation/Foundation.h>

//TODO: Future idea, subclass CWTreeNode & turn it into CWBTreeNode (left/right) children only

@interface CWTreeNode : NSObject
//vars
@property(nonatomic, retain) id value;
@property(nonatomic, assign) __weak id parent;
@property(nonatomic, readonly, retain) NSMutableArray *children;
//methods
-(id)initWithValue:(id)aValue;
-(void)addChild:(CWTreeNode *)node;
-(void)removeChild:(CWTreeNode *)node;
@end
