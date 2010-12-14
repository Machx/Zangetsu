//
//  NSDictionaryAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 11/12/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSDictionary (CWNSDictionaryAdditions)

//Ruby inspired iteration for Objective-C
-(NSDictionary *)cw_each:(void (^)(id key, id value))block;

-(NSDictionary *)cw_eachConcurrentlyWithBlock:(void (^)(id key, id value, BOOL *stop))block;

-(BOOL)cw_dictionaryContainsKey:(NSString *)key;

-(NSDictionary *)cw_mapDictionary:(void (^)(id *key, id *value))block;

@end
