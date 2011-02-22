//
//  CWAppImageCache.m
//  Zangetsu
//
//  Created by Colin Wheeler on 2/22/11.
//  Copyright 2011. All rights reserved.
//

#import "CWAppImageCache.h"


@implementation CWAppImageCache

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+(NSImage *)imageForName:(NSString *)imageName
{
	static NSMutableDictionary *imgCache = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		imgCache = [[NSMutableDictionary alloc] init];
	});
	
	NSImage *_img = nil;
	_img = [imgCache valueForKey:imageName];
	
	if (!_img) {
		_img = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[[NSBundle mainBundle] pathForImageResource:imageName]]];
		[imgCache setValue:_img forKey:imageName];
	}
	
	return _img;
}

@end
