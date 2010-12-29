//
//  CWMD5Utilities.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/29/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSString (CWMD5Utilities)

+(NSString *)cw_md5HashFromString:(NSString *)str;

@end

@interface NSData (CWMD5Utilities)

-(NSString *)cw_md5StringFromData;

@end