/*
//  NSManagedObjectAdditions.m
//
//  Created by Colin Wheeler on 3/19/09.
//  Copyright 2009. All rights reserved.
//
  	*/

#import "NSManagedObjectAdditions.h"


@implementation NSManagedObject(CWNSManagedObjectAdditions)

-(NSString *)cw_objectIDString 
{
	return [[[self objectID] URIRepresentation] absoluteString];
}

-(BOOL)cw_isUsingTemporaryObjectID 
{
	return [[self objectID] isTemporaryID];
}

-(BOOL)cw_setValue:(id)value ifValidForKey:(id)key error:(NSError **)error 
{
	BOOL result = NO;
	result = [self validateValue:&value 
						  forKey:key 
						   error:error];
	if (result == YES)
		[self setValue:value forKey:key];
	
	return result;
}

-(void)cw_setValuesForKeys:(NSDictionary *)moValues
{
	[moValues cw_each:^(id key, id value, BOOL *stop) {
		[self setValue:value forKey:key];
	}];
}

@end
