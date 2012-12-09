/*
//  CWAVLTree.m
//  Zangetsu
//
//  Created by Colin Wheeler on 7/31/12.
//
//
 	*/

#import "CWAVLTree.h"

#define AVLDebug 1

//=============================================
// AVLNode
//=============================================

@interface AVLNode : NSObject
@property(retain) id var;
@property(retain) AVLNode *left;
@property(retain) AVLNode *right;
@property(weak)   AVLNode *parent;
@end

@implementation AVLNode

-(id)init
{
	self = [super init];
	if (self) {
		_var = nil;
		_left = nil;
		_right = nil;
		_parent = nil;
	}
	return self;
}

@end

//=============================================
// AVLTree
//=============================================

//Node Information
NSInteger _levelCountOfDescendentsFromNode(AVLNode *node);
NSInteger weightOfNode(AVLNode *node);
NSComparisonResult compareObjects(id obj1,id obj2, NSComparator comparitor);

//Rotations
AVLNode *rotateLeft(AVLNode *node);
AVLNode *rotateRight(AVLNode *node);
AVLNode *doubleRotateLeftRight(AVLNode *node);
AVLNode *doubleRotateRightLeft(AVLNode *node);

typedef enum AVLNodeDirection : NSInteger {
	kLeftDirection = 1,
	kUndefinedDirection = 0,
	kRightDirection = -1
} AVLNodeDirection;

AVLNodeDirection AVLDirectionOfNodeFromParent(AVLNode *node);

@interface CWAVLTree()
@property(readwrite, assign) NSUInteger count;
@property(retain) AVLNode *root;
-(void)balanceNode:(AVLNode *)node withWeight:(NSInteger)weight;
@end

@implementation CWAVLTree

- (id)init
{
    self = [super init];
    if (self) {
		_root = nil;
		_count = 0;
		_comparitor = [^(id obj1, id obj2){
			return [obj1 compare:obj2];
		} copy];
    }
    return self;
}

NSComparisonResult compareObjects(id obj1,id obj2, NSComparator comparitor)
{
	SEL compareSelector = @selector(compare:);
	if ([obj1 respondsToSelector:compareSelector] &&
		[obj2 respondsToSelector:compareSelector]) {
		return [obj1 compare:obj2];
	}
	if (comparitor) {
		return comparitor(obj1,obj2);
	}
	return NSOrderedSame;
}

NSInteger weightOfNode(AVLNode *node)
{
	NSInteger leftWeight = _levelCountOfDescendentsFromNode(node.left);
	NSInteger rightWeight = _levelCountOfDescendentsFromNode(node.right);
	return (leftWeight - rightWeight);
}

NSInteger _levelCountOfDescendentsFromNode(AVLNode *node)
{
	if(node == nil) { return 0; }
	NSInteger leftCount = _levelCountOfDescendentsFromNode(node.left);
	NSInteger rightCount = _levelCountOfDescendentsFromNode(node.right);
	NSInteger maxSubDepth = MAX(leftCount,rightCount);
	return ++maxSubDepth; //account for the node we are currently on...
}

AVLNode *rotateLeft(AVLNode *node)
{
	CWConditionalLog(AVLDebug, @"rotating left");
	AVLNode *aNode = node.right;
	node.right = aNode.left;
	aNode.left = node;
	return aNode;
}

AVLNode *rotateRight(AVLNode *node)
{
	CWConditionalLog(AVLDebug, @"rotating right");
	AVLNode *aNode = node.left;
	node.left = aNode.right;
	aNode.right = node;
	return aNode;
}

AVLNode *doubleRotateLeftRight(AVLNode *node)
{
	CWConditionalLog(AVLDebug, @"rotating left right");
	node.left = rotateLeft(node.left);
	AVLNode *aNode = rotateRight(node);
	return aNode;
}

AVLNode *doubleRotateRightLeft(AVLNode *node)
{
	CWConditionalLog(AVLDebug, @"rotating right left");
	node.right = rotateRight(node.left);
	AVLNode *aNode = rotateLeft(node);
	return aNode;
}

AVLNodeDirection AVLDirectionOfNodeFromParent(AVLNode *node)
{
	if(!node) { return kUndefinedDirection; }
	AVLNode *nodeParent = node.parent;
	if (nodeParent) {
		if ([nodeParent.left isEqual:node]) {
			return kLeftDirection;
		}
		if ([nodeParent.right isEqual:node]) {
			return kRightDirection;
		}
	}
	return kUndefinedDirection;
}

-(void)balanceNode:(AVLNode *)node withWeight:(NSInteger)weight
{
	NSParameterAssert(node);
	if (weight >= 2) {
		//balance left node
		NSInteger leftWeight = weightOfNode(node.left);
		if (leftWeight == 1) {
			rotateRight(node);
		} else if(leftWeight == -1) {
			doubleRotateLeftRight(node);
		}
	} else if(weight <= -2) {
		//balance right node
		NSInteger rightWeight = weightOfNode(node.right);
		if (rightWeight == 1) {
			rotateLeft(node);
		} else if(rightWeight == -1) {
			doubleRotateRightLeft(node);
		}
	}
}

-(void)addObject:(id)object
{
	CWConditionalLog(AVLDebug, @"Inserting %@...",object);
	if (self.root == nil) {
		AVLNode *node = [[AVLNode alloc] init];
		node.var = object;
		self.root = node;
		CWConditionalLog(AVLDebug, @"Set Root ");
		return;
	}

	AVLNode *currentNode = self.root;
	AVLNode *currentParentNode = nil;
	NSInteger direction = 0;
	while (currentNode) {
		NSComparisonResult compare = compareObjects(currentNode.var, object, self.comparitor);
		if (compare == NSOrderedAscending) {
			currentParentNode = currentNode;
			currentNode = currentNode.right;
			direction = kRightDirection;
			CWConditionalLog(AVLDebug, @"Going Right -->>");
			continue;
		} else if (compare == NSOrderedDescending) {
			currentParentNode = currentNode;
			currentNode = currentNode.left;
			direction = kLeftDirection;
			CWConditionalLog(AVLDebug, @"<<-- Going Left");
			continue;
		} else if (compare == NSOrderedSame) {
			CWConditionalLog(AVLDebug, @"Items are the same");
			return;
		}
	}
	
	AVLNode *node = [[AVLNode alloc] init];
	node.var = object;
	node.parent = currentParentNode;
	if (direction == kRightDirection) {
		currentParentNode.right = node;
	} else if (direction == kLeftDirection) {
		currentParentNode.left = node;
	}
	currentNode = node;
	self.count++;
	
	while (currentNode) {
		NSInteger weight = weightOfNode(currentNode);
		CWConditionalLog(AVLDebug,@"Node Weight: %li",weight);
		if (weight > 1 || weight < -1) {
			[self balanceNode:currentNode
				   withWeight:weight];
		}
		currentNode = currentNode.parent;
	}
}

-(void)removeObject:(id)object
{
	CWDebugLog(@"Not Implemented yet");
}

-(BOOL)objectIsInTree:(id)object
{
	if(!self.root) { return NO; }
	
	if ([self.root.var isEqual:object]) {
		return YES;
	}
	
	AVLNode *currentNode = self.root;
	BOOL result = NO;
	while (currentNode) {
		NSComparisonResult compare = compareObjects(currentNode.var, object, self.comparitor);
		
		if(compare == NSOrderedAscending){
			currentNode = currentNode.right;
			continue;
		} else if(compare == NSOrderedDescending) {
			currentNode = currentNode.left;
			continue;
		} else if (compare == NSOrderedSame) {
			result = YES;
			break;
		}
	}
	
	return result;
}

-(void)enumerateNodesInTreeWithBlock:(void(^)(id obj))block
{
	if (!self.root) { return; }
	
	AVLNode *node = self.root;
	CWQueue *stack = [[CWQueue alloc] init];
	[stack enqueue:node];
	
	while (![stack isEmpty]) {
		AVLNode *aNode = [stack dequeue];
		block(aNode.var);
		
		if (aNode.left) {
			[stack enqueue:aNode.left];
		}
		if (aNode.right) {
			[stack enqueue:aNode.right];
		}
	}
}

@end
