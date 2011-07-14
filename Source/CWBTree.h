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
@property(nonatomic, retain) CWBTreeNode *leftNode;
@property(nonatomic, retain) CWBTreeNode *rightNode;
-(id)initWithValue:(id)aValue;
@end

@interface CWBTree : NSObject
-(id)initWithRootNodeValue:(id)value;
@property(nonatomic, retain) CWBTreeNode *rootNode;
@end
