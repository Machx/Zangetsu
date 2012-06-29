/*
//  UIImage+CWUIImageAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 6/12/12.
//  Copyright (c) 2012. All rights reserved.
//
 
 Copyright (c) 2012 Colin Wheeler
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import <UIKit/UIKit.h>

@interface UIImage (CWUIImageAdditions)

/**
 Resizes a UIImage to the new passed in size
 
 This method is equivalent to calling 
 -cw_imageResizedToSize:size withInterpolationQuality:kCGInterpolationHigh.
 
 @param size The size you wish the UIImage receiver to be resized to.
 @return a new UIImage resized to the desired size
 */
-(UIImage *)cw_imageResizedToSize:(CGSize)size;

/**
 Resizes a UIImage to the new passed in size
 
 This method allows you to resize an image to a specified size and also
 to control the interpolation quality on the new image
 
 @param size The size you wish the UIImage receiver to be resized to.
 @param quality the quality of the interpolation to be done in the resize
 @return a new UIImage resized to the desired size
 */
-(UIImage *)cw_imageResizedToSize:(CGSize)size 
		 withInterpolationQuality:(CGInterpolationQuality)quality;

@end
