/*
//  NSMutableArrayAdditionsTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 9/8/11.
//  Copyright 2012. All rights reserved.
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

#import "CWNSMutableArrayAdditionsTests.h"
#import "NSArray+Search.h"
#import "NSArray+Enumeration.h"
#import "NSArray+Transform.h"
#import "NSMutableArray+Copying.h"
#import "NSMutableArray+Shuffle.h"

SpecBegin(NSMutableArrayAdditions)

//TODO: Test array copying

describe(@"-cw_moveObject:toIndex:", ^{
	it(@"should move an object at one index to another", ^{
		NSMutableArray *array = [[NSMutableArray alloc] initWithArray:@[ @0, @1, @5, @2, @3, @4 ]];
		[array cw_moveObject:@5 toIndex:5];
		[array cw_each:^(id object, NSUInteger index, BOOL *stop) {
			expect(object).to.equal(@(index));
		}];	
	});
	
	it(@"should leave the array as is if object is not contained in the array", ^{
		NSMutableArray *array1 = [[NSMutableArray alloc] initWithArray:@[ @0, @1, @5, @2, @3, @4 ]];
		NSMutableArray *array2 = [array1 copy];
		
		expect(array1).to.equal(array2);
		
		//move a nonexistant object in the array to a new index
		[array1 cw_moveObject:@20 toIndex:2];
		
		expect(array1).to.equal(array2);
	});
});

SpecEnd
