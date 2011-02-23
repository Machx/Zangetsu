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

/**
 cheap and simple image cache for an application
 uses a dictionary to store the images in one place
 and if it cannot find a image it will search the
 apps main bundle to try and find the resource.

 TODO: Allow images to come from more than 1 bundle
 and keep track of which bundle the image is from
 */
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
		if (_img) {
			[imgCache setValue:_img forKey:imageName];
		}
	}
	
	return _img;
}

@end
