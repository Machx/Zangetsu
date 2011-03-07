//
//  CWAppImageCache.h
//  Zangetsu
//
//  Created by Colin Wheeler on 2/22/11.
//  Copyright 2011. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CWAppImageCache : NSObject {}

+(NSImage *)imageForName:(NSString *)imageName ofType:(NSString *)type;

@end
