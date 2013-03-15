/*
//  CWURLRequest.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/13/11.
//  Copyright (c) 2012. All rights reserved.
//
 
 originally wrote on 8/11/2001
 replaced CWURLRequest with code from CWSimpleURLRequest on 12/20/2011

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
 @return a CWURLRequest object	*/
-(id)initWithHost:(NSString *)host;

/**
 Creates the Base64 encoded http authorization header for the instance request
 
 Creates the authorization header string for the instance request. If either 
 login or passwd are nil then this method does nothing. Otherwise it creates
 a Base64 encoded http header string and will be used when this class creates
 it NSMutableURLRequest.
 
<<<<<<< HEAD
 @param login a NSString with the login to the website you making a request from
 @param password a NSString with the password to the website you are making a request from	*/
=======
 @param login a NSString with login account for the header string
 @param password a NSString with the login password for the header string
 */
>>>>>>> upstream/master
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
 
 @return NSData received from the NSURLConnection	*/
-(NSData *)startSynchronousConnection;

/**
 Starts the connection request on a private queue & calls block when finished
 
 This method starts up its own private queue for dispatching its work onto, it 
 then starts the URL connection and then when finished, dispatches back onto the
 main queue. There it calls the block and returns to you the results from the 
 request.
 
 @param data - the data received from the url request
 @param error - if there was an error it will be written here
 @param response - the response received from the url request	*/
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
<<<<<<< HEAD
 @param error if a error was received during this connection is is passed back here
 @param the response received during the connection	*/
=======
 @param error if a error was encountered during this connection it is passed set
 @param the response received during the connection
 */
>>>>>>> upstream/master
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
<<<<<<< HEAD
 @param error if a error was received during this connection is is passed back here
 @param the response received during the connection	*/
=======
 @param error if a error was received during this connection is is set
 @param the response received during the connection
 */
>>>>>>> upstream/master
-(void)startAsynchronousConnectionOnQueue:(NSOperationQueue *)queue 
					  withCompletionBlock:(void (^)(NSData *data, NSError *error, NSURLResponse *response))block;
@end
