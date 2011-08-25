//
//  CWURLRequest.h
//  Zangetsu
//
//  Created by Colin Wheeler on 8/13/11.
//  Copyright 2011. All rights reserved.
//

/**
 Simple URL Request class that can handle redirects
 */

#import <Foundation/Foundation.h>

@interface CWURLRequest : NSObject

@property(nonatomic, retain, readonly) NSString *host;

-(id)initWithURLString:(NSString *)urlHost;

-(void)startSynchronousDownloadWithCompletionBlock:(void (^)(NSData *data, NSError *error))block;

-(void)startAsynchronousDownloadOnQueue:(dispatch_queue_t)queue
                    withCompletionBlock:(void (^)(NSData *data, NSError *error))block;

-(void)startAsynchronousDownloadOnNSOperationQueue:(NSOperationQueue *)queue
                               withCompletionBlock:(void (^)(NSData *data, NSError *error))block;

@end