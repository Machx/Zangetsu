//
//  CWPathUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CWPathUtilities.h"


@implementation CWPathUtilities

+(NSString *)applicationSupportFolder
{
	NSString *_path = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) cw_firstObject];
	
	return _path;
}

+(NSString *)pathByAppendingAppSupportFolderWithPath:(NSString *)path
{
	NSString *_appSupportPath = [CWPathUtilities applicationSupportFolder];
	
	NSString *_result = [NSString stringWithFormat:@"%@/%@",_appSupportPath,path];
	
	return _result;
}

@end
