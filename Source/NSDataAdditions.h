//
//  NSDataAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 1/15/11.
//  Copyright 2011. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSData (CWNSDataAdditions)

-(NSString *)cw_NSStringFromData;

-(const char *)cw_utf8StringFromData;

- (NSData *)cw_gzipDecompress;

- (NSData *)cw_gzipCompress;

@end
