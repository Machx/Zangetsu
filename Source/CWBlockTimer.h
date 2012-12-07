/*
//  CWBlockTimer.h
//  Zangetsu
//
//  Created by Colin Wheeler on 8/10/12.
//
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

#import <Foundation/Foundation.h>

@interface CWBlockTimer : NSObject

/**
 Returns the Internal NSTimer Instance that CWBlockTimer instances manage
 
 @return the Internal NSTimer instance
 */
@property(readonly,retain) NSTimer *internalTimer;

/**
 Invokes the block that the timer is set to fire
 */
-(void)fire;

/**
 Invalidates the NSTimer instance
 */
-(void)invalidate;

/**
 Returns if the internal NSTimer instance is valid
 
 @return a BOOL indicating if the timer instance is valid
 */
-(BOOL)isValid;

/**
 Creates a new CWBlockTimer instance intiailized with the passed in values
 
 @param interval a NSTimeInterval for how long the timer action is supposed to 
 wait till firing
 @param block the block to be executed when the timer fires
 @param repeats a BOOL indicating if the timer should repeat
 @return a new CWBlockTimer instance configured with the parameters passed in
 */
+(CWBlockTimer *)timerWithTimeInterval:(NSTimeInterval)interval
							   repeats:(BOOL)repeats
								 block:(dispatch_block_t)block;

@end
