//
//  CWReachability.h
//  Zangetsu
//
//  Created by Colin Wheeler on 3/26/11.
//  Copyright 2011. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CWReachability : NSObject {}

+(BOOL) canReachAddress:(NSString *)address;

@end
