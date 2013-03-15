/*
//  NSMutableArrayAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 8/26/11.
//  Copyright 2012. All rights reserved.
//
 	*/

#import <Foundation/Foundation.h>

static NSString * const kCWNSMutableArrayAdditionsErrorDomain = @"com.Zangetsu.NSMutableArrayAdditions";

static NSUInteger const kCWNSMutableArrayAdditionsObjectNotFoundCode = 404;

@interface NSMutableArray (CWNSMutableArrayAdditions)

/**
 adds objects from another array to the receiver by copying the objects
 
 adds the objects from otherArray to the receiver by sending the copy message
 to each object before adding it to the receivers array.
 
<<<<<<< HEAD
 @prarm otherArray a NSArray whose objects you want copied and added to the reciver array	*/
=======
 @param otherArray an NSArray whose contents should be copied into the receiver
 */
>>>>>>> upstream/master
-(void)cw_addObjectsFromArrayByCopying:(NSArray *)otherArray;

/**
 Moves the object at whatever index it is at to the specified index
 
 @param object in the receiver you want to move to a new index
 @param index the index you wish to move the specified object to
 */
-(void)cw_moveObject:(id)object
			 toIndex:(NSUInteger)index;

@end
