/*
//  CWRuntimeTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/24/13.
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

static const NSInteger kInstanceCode1 = 100;
static const NSInteger kInstanceCode2 = 200;

static const NSInteger kClassCode1 = 300;
static const NSInteger kClassCode2 = 400;

@interface CWTestFoo : NSObject
-(NSInteger)instanceCode1;
-(NSInteger)instanceCode2;
+(NSInteger)classCode1;
+(NSInteger)classCode2;
@end

@implementation CWTestFoo

-(NSInteger)instanceCode1 {
	return kInstanceCode1;
}

-(NSInteger)instanceCode2 {
	return kInstanceCode2;
}

+(NSInteger)classCode1 {
	return kClassCode1;
}

+(NSInteger)classCode2 {
	return kClassCode2;
}

@end

SpecBegin(CWRuntime)

it(@"should swizzle instance methods", ^{
	CWTestFoo *foo = [CWTestFoo new];
	
	expect(foo.instanceCode1 == kInstanceCode1).to.beTruthy();
	
	expect(foo.instanceCode2 == kInstanceCode2).to.beTruthy();
	
	NSError *swizzleError;
	CWSwizzleInstanceMethods([foo class], @selector(instanceCode1), @selector(instanceCode2), &swizzleError);
	if(swizzleError) NSLog(@"[Instance] Swizzle Error: %@",swizzleError);
	
	expect(foo.instanceCode1 == kInstanceCode2).to.beTruthy();
	
	expect(foo.instanceCode2 == kInstanceCode1).to.beTruthy();
});

it(@"should swizzle class methods", ^{
	expect([CWTestFoo classCode1] == kClassCode1).to.beTruthy();
	
	expect([CWTestFoo classCode2] == kClassCode2).to.beTruthy();
	
	NSError *swizzleError;
	CWSwizzleClassMethods([CWTestFoo class], @selector(classCode1), @selector(classCode2), &swizzleError);
	if(swizzleError) NSLog(@"[Class] Swizzle Error: %@",swizzleError);
	
	expect([CWTestFoo classCode1] == kClassCode2).to.beTruthy();
	
	expect([CWTestFoo classCode2] == kClassCode1).to.beTruthy();
});

SpecEnd
