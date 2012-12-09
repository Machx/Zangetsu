/*
//  UIImage+CWUIImageAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 6/12/12.
//  Copyright (c) 2012. All rights reserved.
//
 	*/

#import <UIKit/UIKit.h>

@interface UIImage (CWUIImageAdditions)

/**
 Resizes a UIImage to the new passed in size
 
 This method is equivalent to calling 
 -cw_imageResizedToSize:size withInterpolationQuality:kCGInterpolationHigh.
 
 @param size The size you wish the UIImage receiver to be resized to.
 @return a new UIImage resized to the desired size	*/
-(UIImage *)cw_imageResizedToSize:(CGSize)size;

/**
 Resizes a UIImage to the new passed in size
 
 This method allows you to resize an image to a specified size and also
 to control the interpolation quality on the new image
 
 @param size The size you wish the UIImage receiver to be resized to.
 @param quality the quality of the interpolation to be done in the resize
 @return a new UIImage resized to the desired size	*/
-(UIImage *)cw_imageResizedToSize:(CGSize)size 
		 withInterpolationQuality:(CGInterpolationQuality)quality;

@end
