/*
//  NSManagedObjectAdditions.m
//
//  Created by Colin Wheeler on 3/19/09.
//  Copyright 2009. All rights reserved.
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

#import "NSManagedObjectAdditions.h"


@implementation NSManagedObject(CWNSManagedObjectAdditions)

-(NSString *)cw_objectIDString {
	return [[[self objectID] URIRepresentation] absoluteString];
}

-(BOOL)cw_isUsingTemporaryObjectID {
	return [[self objectID] isTemporaryID];
}

-(BOOL)cw_setValue:(id)value ifValidForKey:(id)key error:(NSError **)error {
	BOOL result = NO;
	
	result = [self validateValue:&value 
						  forKey:key 
						   error:error];
	
	if (result == YES) {
		[self setValue:value forKey:key];
	}
	
	return result;
}

-(void)cw_setValuesForKeys:(NSDictionary *)moValues
{
	NSArray *values = [moValues allValues];
	NSArray *keys = [moValues allKeys];
	
	for (NSUInteger i = 0; i < [values count]; i++) {
		[self setValue:[values objectAtIndex:i] forKey:[keys objectAtIndex:i]];
	}
}

@end
