//
//  NSMutableArrayAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 8/26/11.
//  Copyright 2011. All rights reserved.
//

#import "NSMutableArrayAdditions.h"

@implementation NSMutableArray (CWNSMutableArrayAdditions)

/**
 adds objects from another array to the receiver by copying the objects
 
 adds the objects from otherArray to the receiver by sending the copy message
 to each object before adding it to the receivers array.
 
 @prarm otherArray a NSArray whose objects you want copied and added to the reciver array
 */
-(void)cw_addObjectsFromArrayByCopying:(NSArray *)otherArray {
    for (id object in otherArray) {
        [self addObject:[object copy]];
    }
}

@end
