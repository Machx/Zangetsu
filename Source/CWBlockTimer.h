/*
//  CWBlockTimer.h
//  Zangetsu
//
//  Created by Colin Wheeler on 8/10/12.
//
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

#import <Foundation/Foundation.h>

@interface CWBlockTimer : NSObject

/**
 Returns the Internal NSTimer Instance that CWBlockTimer instance manages
 
 @return Internal NSTimer instance
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
 
 @param interval how long the timer action is supposed to wait until firing
 @param block the block to be executed when the timer fires
 @param repeats if the timer should repeat
 @return a new CWBlockTimer instance configured with the parameters passed in
 */
+(CWBlockTimer *)timerWithTimeInterval:(NSTimeInterval)interval
							   repeats:(BOOL)repeats
								 block:(dispatch_block_t)block;

@end
