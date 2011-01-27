//
//  GTCoreDataCenter.h
//
//  Created by Colin Wheeler on 9/24/09.
//  Copyright 2009 Colin Wheeler. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CoreData/CoreData.h>

#define CWCDManagedObjectContext() [[CWCoreDataCenter defaultCenter] managedObjectContext]
#define CWCDManagedObjectModel() [[CWCoreDataCenter defaultCenter] managedObjectModel]
#define CWCDPersistentStoreCoordinator() [[CWCoreDataCenter defaultCenter] persistentStoreCoordinator]

@interface CWCoreDataCenter : NSObject {}
+(CWCoreDataCenter *)defaultCenter;
@property(nonatomic,assign) NSManagedObjectModel *managedObjectModel;
@property(nonatomic,assign) NSManagedObjectContext *managedObjectContext;
@property(nonatomic,assign) NSPersistentStoreCoordinator *persistentStoreCoordinator;
/**
 So you can create Core Data centers
 */
-(id)initWithManagedObjectModel:(NSManagedObjectModel *)mom 
		   managedObjectContext:(NSManagedObjectContext *)moc 
  andPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)psc;
@end
