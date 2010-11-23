//
//  NSDictionaryAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/12/10.
//  Copyright 2010. All rights reserved.
//

#import "NSDictionaryAdditions.h"


@implementation NSDictionary (CWNSDictionaryAdditions)

/**
 Ruby Inspired Iterator for NSDictionary in Objective-C
 */
-(NSDictionary *)cw_each:(void (^)(id key, id value))block
{
	for(id key in self) {
		block(key,[self valueForKey:key]);
	}
	
	return self;
}

@end
