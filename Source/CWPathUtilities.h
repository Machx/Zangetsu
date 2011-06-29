//
//  CWPathUtilities.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/20/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define CWFullPathFromTildeString(_X_) [_X_ stringByExpandingTildeInPath]

@interface CWPathUtilities : NSObject
+(NSString *)applicationSupportFolder;
+(NSString *)pathByAppendingAppSupportFolderWithPath:(NSString *)path;
+(NSString *)documentsFolderPathForFile:(NSString *)file;
+(NSString *)pathByAppendingHomeFolderPath:(NSString *)subPath;
+(NSString *)resolveFileAliasPathAtPath:(NSString *)aliasPath error:(NSError **)error;
@end
