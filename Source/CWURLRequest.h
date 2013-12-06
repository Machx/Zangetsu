/*
//  CWURLRequest.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/13/11.
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

//TODO: Consider Removing and rebuilding this on NSURLSession

#import <Foundation/Foundation.h>

//Built in CWSimpleURLRequest Errors
static const NSInteger kCWSimpleURLRequestNoHostError = 404;

@interface CWURLRequest : NSObject
//Properties & Connection Responses
@property(readonly, retain) NSString *urlHost;
@property(readonly, retain) NSURLResponse *connectionResponse;
@property(readonly, retain) NSError *connectionError;
//API

/**
 Initializes the the url request with a host
 
 @param host a valid NSString with the host to be connected to
 @return a CWURLRequest object
 */
-(id)initWithHost:(NSString *)host;

/**
 Creates the Base64 encoded http authorization header for the instance request
 
 Creates the authorization header string for the instance request. If either 
 login or passwd are nil then this method does nothing. Otherwise it creates
 a Base64 encoded http header string and will be used when this class creates
 it NSMutableURLRequest.
 
 @param login a NSString with login account for the header string
 @param password a NSString with the login password for the header string
 */
-(void)setAuthorizationHeaderLogin:(NSString *)login 
					   andPassword:(NSString *)passwd;

/**
 Starts the connection request on the receiving instance
 
 This method causes the receiving object to create the internal 
 NSMutableURLRequest and then creates a NSURLConnection object that references 
 the request object.The connection is then scheduled to run on the current 
 runloop this method is being invoked on and then the connection is started. 
 After this time whatever data is received and whatever error is encountered is
 stored on the instance object. If the data is nil or if you need to debug an
 issue check the instances -connectionErrror and -connectionResponse objects.
 
 @return NSData received from the NSURLConnection
 */
-(NSData *)startSynchronousConnection;

/**
 Starts the connection request on a private queue & calls block when finished
 
 This method starts up its own private queue for dispatching its work onto, it 
 then starts the URL connection and then when finished, dispatches back onto the
 main queue. There it calls the block and returns to you the results from the 
 request.
 
 @param data - the data received from the url request
 @param error - if there was an error it will be written here
 @param response - the response received from the url request
 */
-(void)startAsynchronousConnectionWithCompletionBlock:(void (^)(NSData *data, NSError *error, NSURLResponse *response))block;

/**
 Starts the connection request on another thread in the specified gcd queue
 
 This method is a conveneience method and is the same if you use dispatch async
 and then call -startSynchronousRequest on that other thread and then used 
 dispatch_async to get back to the main thread and passed the NSData, NSError 
 and NSURLResponse objects back. See the notes on -startSynchronousRequest for 
 the implementation details of that method to know whats going on here in this 
 one.
 
 @param data the NSData data received from the connection
 @param error if a error was encountered during this connection it is passed set
 @param the response received during the connection
 */
-(void)startAsynchronousConnectionOnGCDQueue:(dispatch_queue_t)queue 
						 withCompletionBlock:(void (^)(NSData *data, NSError *error, NSURLResponse *response))block;
/**
 Starts the connection request on another thread in the NSOperationQueue
 
 This method is a conveneience method and is the same if you use 
 addOperationWithBLock and then call -startSynchronousRequest on that other 
 thread and then used addOperationWithBlock to get back to the main thread and 
 passed the NSData, NSError and NSURLResponse objects back. See the notes on 
 -startSynchronousRequest for the implementation details of that method to know 
 whats going on here in this one. 
 
 @param data the NSData data received from the connection
 @param error if a error was received during this connection is is set
 @param the response received during the connection
 */
-(void)startAsynchronousConnectionOnQueue:(NSOperationQueue *)queue 
					  withCompletionBlock:(void (^)(NSData *data, NSError *error, NSURLResponse *response))block;
@end
