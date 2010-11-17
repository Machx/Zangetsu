//
//  NSStringAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 11/5/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSString (CWNSStringAdditions) 

- (void)cw_enumerateConcurrentlyWithOptions:(NSStringEnumerationOptions)options
                                 usingBlock:(void (^)(NSString *substring))block;
- (NSString *) stringByUnescapingEntities: (NSDictionary *) entitiesDictionary;
- (NSString *) stringByAddingPercentEscapesUsingEncoding: (NSStringEncoding) encoding legalURLCharactersToBeEscaped: (NSString *) legalCharacters;
- (NSString *) stringByReplacingPercentEscapes;

@end
