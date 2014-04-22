//
//  CWURLRequestTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 4/21/14.
//
//

#import <XCTest/XCTest.h>
#import "CWURLRequest.h"
#import "OHHTTPStubs.h"

SpecBegin(CWURLRequest)

beforeAll(^{
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:@"www.apple.com"];
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        NSData *data = [@"Hello There!" dataUsingEncoding:NSUTF8StringEncoding];
        return [OHHTTPStubsResponse responseWithData:data statusCode:200 headers:nil];
    }];
});

afterAll(^{
    [OHHTTPStubs removeAllStubs];
});

it(@"should return expected data from a synchronous request", ^{
    CWURLRequest *request = [[CWURLRequest alloc] initWithHost:@"http://www.apple.com/mac"];
    
    NSData *data = [request startSynchronousConnection];
    
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    expect(response).to.equal(@"Hello There!");
});

it(@"should return expected data from a asynchronous request", ^{
    CWURLRequest *request = [[CWURLRequest alloc] initWithHost:@"http://www.apple.com/mac"];
    
    __block NSString *result = nil;
    
    [request startAsynchronousConnectionWithCompletionBlock:^(NSData *data, NSError *error, NSURLResponse *response) {
        result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }];
    
    expect(result).will.equal(@"Hello There!");
});

it(@"should return expected data from a asynchronous request on a gcd queue", ^{
    CWURLRequest *request = [[CWURLRequest alloc] initWithHost:@"http://www.apple.com/mac"];
    
    __block NSString *result = nil;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    [request startAsynchronousConnectionOnGCDQueue:queue withCompletionBlock:^(NSData *data, NSError *error, NSURLResponse *response) {
        result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }];
    
    expect(result).will.equal(@"Hello There!");
});

it(@"should return expected data from a asynchronous request on a queue", ^{
    CWURLRequest *request = [[CWURLRequest alloc] initWithHost:@"http://www.apple.com/mac"];
    
    __block NSString *result = nil;
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    
    [request startAsynchronousConnectionOnQueue:queue withCompletionBlock:^(NSData *data, NSError *error, NSURLResponse *response) {
        result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }];
    
    expect(result).will.equal(@"Hello There!");
});

SpecEnd
