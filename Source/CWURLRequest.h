/*
//  CWURLRequest.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/13/11.
//  Copyright (c) 2011. All rights reserved.
//
 
 originally wrote on 8/11/2001
 replaced CWURLRequest with code from CWSimpleURLRequest on 12/20/2011

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

#import <Foundation/Foundation.h>

//Built in CWSimpleURLRequest Errors
static const NSInteger kCWSimpleURLRequestNoHostError = 404;

@interface CWURLRequest : NSObject
//Properties & Connection Responses
@property(nonatomic, readonly, retain) NSString *urlHost;
@property(nonatomic, readonly, retain) NSURLResponse *connectionResponse;
@property(nonatomic, readonly, retain) NSError *connectionError;
//API
-(id)initWithHost:(NSString *)host;

#if !(TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
// Base64 imp on Lion used SecTransform which is not available
// on iOS, will need to come up with a iOS specific implementation
// before this api will be available
-(void)setAuthorizationHeaderLogin:(NSString *)login 
					   andPassword:(NSString *)passwd;
#endif

-(NSData *)startSynchronousConnection;

-(void)startAsynchronousConnectionOnGCDQueue:(dispatch_queue_t)queue 
						 withCompletionBlock:(void (^)(NSData *data, NSError *error, NSURLResponse *response))block;

-(void)startAsynchronousConnectionOnQueue:(NSOperationQueue *)queue 
					  withCompletionBlock:(void (^)(NSData *data, NSError *error, NSURLResponse *response))block;
@end
