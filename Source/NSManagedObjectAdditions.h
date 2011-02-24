//
//  NSManagedObjectAdditions.h
//
//  Created by Colin Wheeler on 3/19/09.
//  Copyright 2009. All rights reserved.
//

#import <CoreData/NSManagedObject.h>


@interface NSManagedObject(CWNSManagedObjectAdditions) 
-(NSString *)cw_objectIDString;
-(BOOL)cw_isUsingTemporaryObjectID;
-(NSArray *)cw_validateValuesAndKeys:(NSArray *)values;
@end
