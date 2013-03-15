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
 Takes the contents of the receiver & returns a new base64 encoded string
 
<<<<<<< HEAD
 @return a new NSString object with the contents of the receiver string encoded in Base 64 encoding	*/
=======
 @return A new NSString object with the base64 encoded version of the receiver
 */
>>>>>>> upstream/master
- (NSString *)cw_base64EncodedString;

/**
 Takes the contents of the receiver & returns a new base64 decoded string
 
<<<<<<< HEAD
 @return a new NSString object with the contents of the receiver string decoded from Base 64 encoding	*/
=======
 @return A new NSString object with the base64 decoded version of the receiver
 */
>>>>>>> upstream/master
- (NSString *)cw_base64DecodedString;
@end
