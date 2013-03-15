/*
//  NSURL+CWURLAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 7/21/12.
//  Copyright (c) 2012. All rights reserved.
//
 	*/

#import <Foundation/Foundation.h>

@interface NSURL (CWURLAdditions)

/**
 A better string description of a NSURL including host, port, path, etc
 
 @return a NSString with a much better string url description than -description
 */
-(NSString *)cw_betterDescription;

@end
