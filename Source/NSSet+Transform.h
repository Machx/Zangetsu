/*
//  NSSet+Transform.h
//  Zangetsu
//
//  Created by Colin Wheeler on 8/27/13.
//
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

@interface NSSet (Zangetsu_NSSet_Transform)

/**
 Maps an NSSet to a new NSSet
 
 This method allows you to map one NSSet to another one and in the process you
 can alter the set or simply do 1-to-1 mapping. This method calls a block with
 each object in a set and expects to get an object back or nil. If the block
 returns an object it stores that object in the new set, otherwise if it gets
 nil back then it does not store anything in the new set for that specific
 block callback.
 
 @param block a block with an id object argument for the object being enumerated
 over in the set and expecting an id object or nil back
 @return a NSSet with the mapped set. If nil was returned for all block
 callbacks this simply returns an empty NSSet
 */
-(NSSet *)cw_mapSet:(id (^)(id obj))block;

@end
