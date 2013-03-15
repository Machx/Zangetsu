/*
//  NSImage+CW.h
//  Zangetsu
//
//  Created by Colin Wheeler on 7/7/12.
//  Copyright (c) 2012. All rights reserved.
//
 	*/

#import <Cocoa/Cocoa.h>

@interface NSImage (CWNSImageAdditions)

/**
 Returns a new image of the receiver resized to the specified size
 
 This method is equivalent to calling 
 cw_imageResizedToSize:size withInterPolationQuality:kCGInterpolationHigh
 
 @param size a CGSize spec that the object should be resized to
<<<<<<< HEAD
 @return a new NSImage object that has been scaled to the new size or nil if something went wrong	*/
=======
 @return a new NSImage object that has been scaled to size or nil
 */
>>>>>>> upstream/master
-(NSImage *)cw_imageResizedToSize:(CGSize)size;

/**
 Returns a new image of the receiver resized to the specified size
 
 @param size a CGSize spec that the object should be resized to
<<<<<<< HEAD
 @param quality the amount of interpolation quality that should be applied to the resize
 @return a new NSImage object that has been scaled to the new size or nil if something went wrong	*/
=======
 @param quality interpolation quality that should be applied to the resize
 @return a new NSImage object that has been scaled to the new size or nil
 */
>>>>>>> upstream/master
-(NSImage *)cw_imageResizedToSize:(CGSize)size 
		 withInterpolationQuality:(CGInterpolationQuality)quality;

@end
