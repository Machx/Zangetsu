/*
//  NSManagedObjectAdditions.h
//
//  Created by Colin Wheeler on 3/19/09.
//  Copyright 2009. All rights reserved.
//
 	*/

#import <CoreData/NSManagedObject.h>


@interface NSManagedObject(CWNSManagedObjectAdditions) 
-(NSString *)cw_objectIDString;
-(BOOL)cw_isUsingTemporaryObjectID;
-(BOOL)cw_setValue:(id)value ifValidForKey:(id)key error:(NSError **)error;
-(void)cw_setValuesForKeys:(NSDictionary *)moValues;
@end
