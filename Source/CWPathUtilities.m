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
 Conveince method for returing the apps Application Support folder
 */
+(NSString *)applicationSupportFolder
{
	NSString *_path = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) cw_firstObject];
	
	NSString *_appName = [[[NSBundle mainBundle] infoDictionary] valueForKey:kCWAppName];
	
	return [NSString stringWithFormat:@"%@/%@",_path,_appName];
}

/**
 Gets the application support folder and appends the string onto it
 */
+(NSString *)pathByAppendingAppSupportFolderWithPath:(NSString *)path
{
	NSString *_appSupportPath = [CWPathUtilities applicationSupportFolder];
	
	NSString *_result = [NSString stringWithFormat:@"%@/%@",_appSupportPath,path];
	
	return _result;
}

/**
 Gets the home folder path & appends the subpath onto it
 */
+(NSString *)pathByAppendingHomeFolderPath:(NSString *)subPath
{
	NSString * _homeFolder = NSHomeDirectory();
	
	return [NSString stringWithFormat:@"%@/%@",_homeFolder,subPath];
}

@end
