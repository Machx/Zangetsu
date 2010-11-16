//
//  NSSetAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 11/15/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSSet (CWNSSetAdditions) 

-(id)cw_find:(BOOL (^)(id obj))block;

@end
