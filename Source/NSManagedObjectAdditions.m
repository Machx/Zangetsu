//
//  NSManagedObjectAdditions.m
//
//  Created by Colin Wheeler on 3/19/09.
//  Copyright 2009. All rights reserved.
//

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

@end
