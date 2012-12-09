/*
//  CWBlockTimer.h
//  Zangetsu
//
//  Created by Colin Wheeler on 8/10/12.
//
//
 	*/

#import <Foundation/Foundation.h>

@interface CWBlockTimer : NSObject

/**
 Returns the Internal NSTimer Instance that CWBlockTimer instances manage
 
 @return the Internal NSTimer instance	*/
@property(readonly,retain) NSTimer *internalTimer;

/**
 Invokes the block that the timer is set to fire	*/
-(void)fire;

/**
 Invalidates the NSTimer instance	*/
-(void)invalidate;

/**
 Returns if the internal NSTimer instance is valid
 
 @return a BOOL indicating if the timer instance is valid	*/
-(BOOL)isValid;

/**
 Creates a new CWBlockTimer instance intiailized with the passed in values
 
 @param interval a NSTimeInterval for how long the timer action is supposed to wait till firing
 @param block the block to be executed when the timer fires
 @param repeats a BOOL indicating if the timer should repeat
 @return a new CWBlockTimer instance configured with the parameters passed in	*/
+(CWBlockTimer *)timerWithTimeInterval:(NSTimeInterval)interval
							   repeats:(BOOL)repeats
								 block:(dispatch_block_t)block;

@end
