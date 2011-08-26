//
//  NSMutableArrayAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 8/26/11.
//  Copyright 2011. All rights reserved.
//

#import "NSMutableArrayAdditions.h"

@implementation NSMutableArray (CWNSMutableArrayAdditions)

-(void)cw_addObjectsFromArray:(NSArray *)otherArray copyItems:(BOOL)copy {
    for (id object in otherArray) {
        if (copy) {
            [self addObject:[object copy]];
        } else {
            [self addObject:object];
        }
    }
}

@end
