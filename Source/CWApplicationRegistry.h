//
//  CWApplicationRegistry.h
//  Zangetsu
//
//  Created by Colin Wheeler on 5/15/11.
//  Copyright 2011. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CWApplicationRegistry : NSObject

+(BOOL)applicationIsRunning:(NSString *)appName;

@end
