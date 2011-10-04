/*
//  CWURLRequest.h
//  Zangetsu
//
//  Created by Colin Wheeler on 8/13/11.
//  Copyright 2011. All rights reserved.
//
 
 Copyright (c) 2011 Colin Wheeler
 
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

/**
 Simple URL Request class that can handle redirects
 */

#import <Foundation/Foundation.h>

@interface CWURLRequest : NSObject

@property(nonatomic, retain, readonly) NSString *host;
@property(nonatomic, readonly, retain) NSError *urlError;

@property(nonatomic, assign) NSURLRequestCachePolicy cachePolicy;
@property(nonatomic, assign) NSTimeInterval timeoutInterval;

-(id)initWithURLString:(NSString *)urlHost;

-(void)setAuthenticationHTTPHeaderLogin:(NSString *)login 
                            andPassword:(NSString *)password;

-(void)setAuthenticationChallengeLogin:(NSString *)uLogin 
                           andPassword:(NSString *)uPassword;

-(BOOL)canHandleRequest;

-(void)startSynchronousDownloadWithCompletionBlock:(void (^)(NSData *data, NSError *error))block;

-(void)startAsynchronousDownloadOnQueue:(dispatch_queue_t)queue
                    withCompletionBlock:(void (^)(NSData *data, NSError *error))block;

-(void)startAsynchronousDownloadOnNSOperationQueue:(NSOperationQueue *)queue
                               withCompletionBlock:(void (^)(NSData *data, NSError *error))block;

@end