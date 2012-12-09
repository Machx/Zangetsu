/*
//  CWBase64IOS.h
//  Zangetsu
//
//  Created by Colin Wheeler on 2/2/12.
//  Copyright (c) 2012. All rights reserved.
//
 	*/
 
#import <Foundation/Foundation.h>

@interface NSData (iOSBase64)
+ (id)cw_dataWithBase64EncodedString:(NSString *)string;
- (NSString *)cw_base64EncodedString;
@end

@interface NSString (iOSBase64)
-(NSString *)cw_base64EncodedString;
@end
