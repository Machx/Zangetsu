//
//  CWPathUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/20/10.
//  Copyright 2010. All rights reserved.
//

#import "CWPathUtilities.h"

static NSString * const kCWAppName = @"CFBundleName";

@implementation CWPathUtilities

/**
 * Conveince method for returing the apps Application Support folder
 */
+ (NSString *) applicationSupportFolder {
    NSString * _path = nil;
    _path = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) cw_firstObject];
    if (!_path) {
        return nil;
    }
    
    NSString * _appName = [[[NSBundle mainBundle] infoDictionary] valueForKey:kCWAppName];

    return [NSString stringWithFormat:@"%@/%@", _path, _appName];
}

/**
 * Gets the application support folder and appends the string onto it
 */
+ (NSString *) pathByAppendingAppSupportFolderWithPath:(NSString *)path {
    NSString * _appSupportPath = nil;
    _appSupportPath = [CWPathUtilities applicationSupportFolder];
    if (!_appSupportPath) {
        return nil;
    }

    NSString * _result = [NSString stringWithFormat:@"%@/%@", _appSupportPath, path];

    return _result;
}

/**
 * Gets the home folder path & appends the subpath onto it
 */
+ (NSString *) pathByAppendingHomeFolderPath:(NSString *)subPath {
    NSString * _homeFolder = NSHomeDirectory();

    return [NSString stringWithFormat:@"%@/%@", _homeFolder, subPath];
}

+(NSString *)resolveFileAliasPathAtPath:(NSString *)aliasPath error:(NSError **)error {
	NSString *resolvedPath = nil;
	
	resolvedPath = [[NSFileManager defaultManager] destinationOfSymbolicLinkAtPath:aliasPath error:error];
	
	return resolvedPath;
}

@end
