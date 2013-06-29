/*
//  UIImage+CWUIImageAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 6/12/12.
//  Copyright (c) 2012. All rights reserved.
//
 
 Copyright (c) 2013, Colin Wheeler
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 - Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
