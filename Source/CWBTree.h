//
//  CWBTree.h
//  Zangetsu
//
//  Created by Colin Wheeler on 7/14/11.
//  Copyright 2011. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWBTreeNode : NSObject
@property(nonatomic, retain) id value;
@property(nonatomic, assign) __weak CWBTreeNode *parent;
@property(nonatomic, retain, readonly) CWBTreeNode *leftNode;
@property(nonatomic, retain, readonly) CWBTreeNode *rightNode;
-(id)initWithValue:(id)aValue;
-(void)assignLeftNode:(CWBTreeNode *)node;
-(void)assignRightNode:(CWBTreeNode *)node;
@end

@interface CWBTree : NSObject
-(id)initWithRootNodeValue:(id)value;
@property(nonatomic, retain) CWBTreeNode *rootNode;
-(void)enumerateBTreeWithBlock:(void (^)(id nodeValue, id node, BOOL *stop))block;
@end
