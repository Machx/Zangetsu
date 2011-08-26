//
//  NSMutableArrayAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 8/26/11.
//  Copyright 2011. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (CWNSMutableArrayAdditions)

-(void)cw_addObjectsFromArray:(NSArray *)otherArray copyItems:(BOOL)copy;

@end
