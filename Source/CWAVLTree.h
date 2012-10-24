/*
//  CWAVLTree.h
//  Zangetsu
//
//  Created by Colin Wheeler on 7/31/12.
//
//
 
 */

/**
 EXPERIMENTAL WORK IN PROGRESS - DON'T USE
 Most of it doesn't work yet anyway...
 */

#import <Foundation/Foundation.h>

@interface CWAVLTree : NSObject

@property(copy) NSComparator comparitor;

@property(readonly, assign) NSUInteger count;

-(void)addObject:(id)object;

-(void)removeObject:(id)object;

-(BOOL)objectIsInTree:(id)object;

-(void)enumerateNodesInTreeWithBlock:(void(^)(id obj))block;

@end
