/*
//  NSSetAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 11/15/10.
//  Copyright 2010. All rights reserved.
//
 
 */

#import <Foundation/Foundation.h>


@interface NSSet (CWNSSetAdditions) 

/**
 Ruby Inspired method for enumerating over Objects in a set
 
 This method is really a wrapper for NSArrays -enumerateObjectsUsingBlock
 now and makes the code a little more conscice. It enumerates over all the
 objects in the set or until the bool pointer is set to YES.
 
 @param block a block taking a id and BOOL pointer arguments
 */
-(void)cw_each:(void (^)(id obj, BOOL *stop))block;

/**
 Enumerates over all the objects in a set or until the blocks stop pointer is set to YES
 
 Enumerates over all the objects in a set. This method creates its own dispatch_queue_t
 and gives it a unique label such as "com.Zangetsu.NSSetAdditions_ConncurrentEach" appended
 with a UUID string. This method then concurrently enumerates all objects or until the 
 stop pointer is set to yes and waits until all blocks have finished executing before exiting.
 
 @param block a Block taking a id and BOOL* arguments
 */
-(void)cw_eachConcurrentlyWithBlock:(void (^)(id obj,BOOL *stop))block;

/**
 Enumerates over all the object in a set till a block returns YES & returns that, otherwise returns nil
 
 Enumerates over all the objects in a set calling block and passing in a object from the set and checking
 to see if the return value is YES or NO. As soon as any block returns YES then this method exits and
 returns the object that it passed to the block that returned YES. Otherwise if no block returns YES then
 this method simply returns nil.
 
 @param block a Block taking a id argument and expecting a BOOL return value
 @return an object if any block returned YES, otherwise nil
 */
-(id)cw_findWithBlock:(BOOL (^)(id obj))block;

/**
 Enumerates over all objects in a set and returns all objects where the block callback returned YES
 
 This method allows you to deeply inspect all objects in a set and return multiple objects you have
 an interest in. This method creates a new set and adds the objects it passed in to blocks that
 returned YES to that set.
 
 @param block a block taking an id argument which is an object in the set and returning a BOOL value
 @return a NSSet with all objects where blocks returned YES or an empty NSSet
 */
-(NSSet *)cw_findAllWithBlock:(BOOL (^)(id obj))block;

/**
 Enumerates over all the objects with a block till one returns YES otherwise returns NO
 
 This method enumerates over all the objects in a set till a block callback returns YES,
 otherwise it returns NO. 
 
 @param a block taking an id argument and returning a BOOL value
 @return a BOOL value with YES if a block returned YES otherwise returns NO
 */
-(BOOL)cw_isObjectInSetWithBlock:(BOOL (^)(id obj))block;

#if Z_HOST_OS_IS_MAC_OS_X
/**
 This method is the same as cw_findAllWithBlock except that it stores the objects in a NSHashTable
 
 This method enumerates over all the objects in a set and returns a NSHashTable with all objects
 where the block callback returned YES. If no blocks returned YES then this returns an empty
 NSHashTable.
 
 @param a block with a id argument and a BOOL return value
 @return a NSHashTable with all objects where the block call back returned YES, otherwise an empty NSHashTable if none return YES
 */
-(NSHashTable *)cw_findAllIntoWeakRefsWithBlock:(BOOL (^)(id))block;
#endif

/**
 Maps an NSSet to a new NSSet
 
 This method allows you to map one NSSet to another one and in the process you can alter the set
 or simply do 1-to-1 mapping. This method calls a block with each object in a set and expects to
 get an object back or nil. If the block returns an object it stores that object in the new set,
 otherwise if it gets nil back then it does not store anything in the new set for that specific 
 block callback. 
 
 @param block a block with an id object argument for the object being enumerated over in the set and expecting an id object or nil back
 @return a NSSet with the mapped set. If nil was returned for all block callbacks this simply returns an empty NSSet
 */
-(NSSet *)cw_mapSet:(id (^)(id obj))block;

@end
