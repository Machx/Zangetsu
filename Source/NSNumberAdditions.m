/*
//  NSNumber+NSNumberAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 2/24/13.
//
//
 	*/

<<<<<<< HEAD:Source/CWAVLTree.h
/**
 EXPERIMENTAL WORK IN PROGRESS - DON'T USE
 Most of it doesn't work yet anyway...	*/

#import <Foundation/Foundation.h>

@interface CWAVLTree : NSObject

@property(copy) NSComparator comparitor;

@property(readonly, assign) NSUInteger count;

-(void)addObject:(id)object;

-(void)removeObject:(id)object;
=======
#import "NSNumberAdditions.h"
>>>>>>> upstream/master:Source/NSNumberAdditions.m

@implementation NSNumber (CWNSNumberAdditions)

-(void)cw_times:(void (^)(NSInteger index, BOOL *stop))block {
	NSInteger count = [self integerValue];
	BOOL stop = NO;
	for (NSInteger i = 0; i < count; i++) {
		block(i,&stop);
		if (stop == YES) break;
	}
}

@end
