//
//  NSArrayAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler 

#import <Cocoa/Cocoa.h>


@interface NSArray (CWNSArrayAdditions)

-(id)cw_firstObject;

//Ruby inspired iterators
-(NSArray *)cw_each:(void (^)(id obj))block;

-(NSArray *)cw_eachWithIndex:(void (^)(id obj,NSInteger index))block;

-(id)cw_find:(BOOL (^)(id obj))block;

@end
