//
//  NSSetAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 11/15/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSSet (CWNSSetAdditions) 

-(NSSet *)cw_each:(void (^)(id obj))block;

-(NSSet *)cw_eachConcurrentlyWithBlock:(void (^)(id obj,BOOL *stop))block;

-(id)cw_findWithBlock:(BOOL (^)(id obj))block;

-(BOOL)cw_isObjectInSetWithBlock:(BOOL (^)(id obj))block;

-(NSSet *)cw_findAllWithBlock:(BOOL (^)(id obj))block;

-(NSHashTable *)cw_findAllIntoWeakRefsWithBlock:(BOOL (^)(id))block;

-(NSSet *)cw_mapSet:(id (^)(id obj))block;

-(NSSet *)cw_selectivelyMapSet:(id (^)(id obj))block;

@end
