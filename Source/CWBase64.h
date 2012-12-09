/*
//  CWBase64.h
//  Zangetsu
//
//  Created by Colin Wheeler on 9/18/11.
//  Copyright 2012. All rights reserved.
//
 	*/

#import <Foundation/Foundation.h>

@interface NSString (CWBase64Encoding)

/**
 takes a NSString & converts its encoding to Base 64 encoding and returns a new NSString object
 
 @return a new NSString object with the contents of the receiver string encoded in Base 64 encoding	*/
- (NSString *)cw_base64EncodedString;

/**
 takes a NSString & converts its encoding from Base 64 encoding and returns a new NSString object
 
 @return a new NSString object with the contents of the receiver string decoded from Base 64 encoding	*/
- (NSString *)cw_base64DecodedString;
@end
