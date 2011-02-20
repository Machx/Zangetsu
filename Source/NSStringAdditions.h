//
//  NSStringAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 11/5/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSString (CWNSStringAdditions) 

+ (NSString *)cw_uuidString;
- (void)cw_enumerateConcurrentlyWithOptions:(NSStringEnumerationOptions)options
                                 usingBlock:(void (^)(NSString *substring))block;
- (NSString *) cw_stringByUnescapingEntities: (NSDictionary *) entitiesDictionary;
- (NSString *) cw_stringByAddingPercentEscapesUsingEncoding: (NSStringEncoding) encoding legalURLCharactersToBeEscaped: (NSString *) legalCharacters;
- (NSString *) cw_stringByReplacingPercentEscapes;
- (NSString *) cw_escapeEntitiesForURL;
- (BOOL) cw_isNotEmptyString;

@end
