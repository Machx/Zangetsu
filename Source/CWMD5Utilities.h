/*
//  CWMD5Utilities.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/29/10.
//  Copyright 2010. All rights reserved.
//
 	*/

#import <Foundation/Foundation.h>


@interface NSString (CWMD5Utilities)
/**
 Return the MD5 value of the string passed in	*/
+(NSString *)cw_md5HashFromString:(NSString *)str;
@end

@interface NSData (CWMD5Utilities)
/**
<<<<<<< HEAD
 Convience method to return the MD5 value of the contents of a NSData object given	*/
=======
 Convience method to return the MD5 value of the contents of an object given
 */
>>>>>>> upstream/master
-(NSString *)cw_md5StringFromData;
@end
