//
//  CWNSURLConnectionAdditionsTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 4/20/14.
//
//

#import <XCTest/XCTest.h>
#import "NSURLConnection+Asynchronous.h"

static NSString * const kAppleResponse = @"All Glory to the Hypnotoad";

SpecBegin(NSURLConnectionAdditions)

beforeAll(^{
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:@"www.apple.com"];
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        NSData *data = [kAppleResponse dataUsingEncoding:NSUTF8StringEncoding];
        return [OHHTTPStubsResponse responseWithData:data statusCode:200 headers:nil];
    }];
});

afterAll(^{
    [OHHTTPStubs removeAllStubs];
});

//TODO: Update these to new API's or remove
//it(@"should return the expected response from a synchronous request", ^{
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.apple.com"]];
//    NSURLResponse *response;
//    NSError *error;
//    NSData *data = [NSURLConnection cw_performGCDSynchronousRequest:request
//                                                           response:&response
//                                                              error:&error];
//
//    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//    expect(responseString).to.equal(kAppleResponse);
//});
//
//it(@"should return the expected response from an ansyncrhonous request", ^{
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.apple.com"]];
//
//    __block NSString *responseString;
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//    [NSURLConnection cw_performAsynchronousRequest:request onGCDQueue:queue completionBlock:^(NSData *data, NSURLResponse *response, NSError *error) {
//        responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    }];
//
//    expect(responseString).will.equal(kAppleResponse);
//});

SpecEnd
