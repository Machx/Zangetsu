//
//  CWAppImageCache.m
//  Zangetsu
//
//  Created by Colin Wheeler on 2/22/11.
//  Copyright 2011. All rights reserved.
//

#import "CWAppImageCache.h"


@implementation CWAppImageCache

@synthesize cacheCapacity;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(id)initWithCapacityCount:(NSUInteger)capacity {
    self = [super init];
    if (self) {
        cacheCapacity = capacity;
    }
    return self;
}

-(NSImage *)imageForName:(NSString *)imageName ofType:(NSString *)type
{
	static NSMutableDictionary *imgCache = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		if ([self cacheCapacity] != 0) {
            imgCache = [[NSMutableDictionary alloc] initWithCapacity:cacheCapacity];
        } else {
            imgCache = [[NSMutableDictionary alloc] init];
        }
	});
	
	NSImage *_img = nil;
	_img = [imgCache valueForKey:imageName];
	
	if (!_img) {
		_img = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:imageName ofType:type]]];
		if (_img) {
			[imgCache setValue:_img forKey:[NSString stringWithFormat:@"%@%@",imageName,type]];
		}
	}
	
	return _img;
}

@end
