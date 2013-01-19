/*
//  NSMutableArrayAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 8/26/11.
//  Copyright 2012. All rights reserved.
//
 	*/

#import <Foundation/Foundation.h>

@interface NSMutableArray (CWNSMutableArrayAdditions)

/**
 adds objects from another array to the receiver by copying the objects
 
 adds the objects from otherArray to the receiver by sending the copy message
 to each object before adding it to the receivers array.
 
 @prarm otherArray a NSArray whose objects you want copied and added to the reciver array	*/
-(void)cw_addObjectsFromArrayByCopying:(NSArray *)otherArray;

-(void)cw_moveObject:(id)object
			 toIndex:(NSUInteger)index;

@end
