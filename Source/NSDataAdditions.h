/*
//  NSDataAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 1/15/11.
//  Copyright 2012. All rights reserved.
//
 	*/

#import <Foundation/Foundation.h>


@interface NSData (CWNSDataAdditions)

/**
 Returns a NSString from the contents of the data encoded in UTF8 encoding
 
 @return a NSString from the contents of the NSData object, if the data object is nil this returns nil	*/
-(NSString *)cw_NSStringFromData;

/**
 Returns a const char from the contents of the NSData object encoded in UTF8 encoding
 
 @return a const char * from the contents of the NSData object, if the data object is nil this returns nil	*/
-(const char *)cw_utf8StringFromData;

/**
 returns a string with the representation of the data in hex
 
 @return a NSString with the data representation in hex or nil if the data is nil or its length is 0	*/
-(NSString *)cw_hexString;

@end
