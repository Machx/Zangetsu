/*
//  NSURLConnectionAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/6/10.
//  Copyright 2010. All rights reserved.
//
 	*/

#import <Foundation/Foundation.h>


@interface NSURLConnection (CWNSURLConnectionAdditions)

/**
 Checks the Queue and request parameters then dispatches a block onto
 the passed in queue, executes a synchronous request and then dispatches
 a block back onto the main thread and executes the block passed in	*/
+(void)cw_performAsynchronousRequest:(NSURLRequest *)request 
						  onGCDQueue:(dispatch_queue_t)queue 
					 completionBlock:(void (^)(NSData *data, NSURLResponse *response, NSError *error))block;

/**
 Checks the passed in NSURLRequest and then uses dispatch_sync to 
 perform the syncrhonous request. In general this is used only in 
 some specific cercumstances otherwise this could potentially
 block the main thread (if you are executing this method on there.)	*/
+(NSData *)cw_performGCDSynchronousRequest:(NSURLRequest *)request 
								  response:(NSURLResponse **)response 
								  andError:(NSError **)error;

@end
