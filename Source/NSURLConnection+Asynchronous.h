/*
//  NSURLConnectionAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/6/10.
//  Copyright 2010. All rights reserved.
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


@interface NSURLConnection (Zangetsu_NSURLConnection_Asynchronous)

/**
 Checks the Queue and request parameters then dispatches a block onto
 the passed in queue, executes a synchronous request and then dispatches
 a block back onto the main thread and executes the block passed in
 */
+(void)cw_performAsynchronousRequest:(NSURLRequest *)request 
						  onGCDQueue:(dispatch_queue_t)queue 
					 completionBlock:(void (^)(NSData *data, NSURLResponse *response, NSError *error))block __attribute__((deprecated));

/**
 Checks the passed in NSURLRequest and then uses dispatch_sync to 
 perform the syncrhonous request. In general this is used only in 
 some specific cercumstances otherwise this could potentially
 block the main thread (if you are executing this method on there.)
 */
+(NSData *)cw_performGCDSynchronousRequest:(NSURLRequest *)request 
								  response:(NSURLResponse **)response 
									 error:(NSError **)error __attribute__((deprecated));

@end
