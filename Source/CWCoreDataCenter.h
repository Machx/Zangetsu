/*
//  GTCoreDataCenter.h
//
//  Created by Colin Wheeler on 9/24/09.
//  Copyright 2009 Colin Wheeler. All rights reserved.
//
 	*/

#import <CoreData/CoreData.h>

#define CWCDManagedObjectContext() [[CWCoreDataCenter defaultCenter] managedObjectContext]
#define CWCDManagedObjectModel() [[CWCoreDataCenter defaultCenter] managedObjectModel]
#define CWCDPersistentStoreCoordinator() [[CWCoreDataCenter defaultCenter] persistentStoreCoordinator]

/**
 CWCoreDataCenter is a simple class used for maintaining pointers to a
 Managed Object Model, a Managed Object Context and a persistent store
 coordinator. In particular it makes it easy to point back to the main
 managed object context/model/coordinator for common core data operations	*/

@interface CWCoreDataCenter : NSObject
+(CWCoreDataCenter *)defaultCenter;
@property(assign) NSManagedObjectModel *managedObjectModel;
@property(assign) NSManagedObjectContext *managedObjectContext;
@property(assign) NSPersistentStoreCoordinator *persistentStoreCoordinator;
/**
 So you can create Core Data centers	*/
-(id)initWithManagedObjectModel:(NSManagedObjectModel *)mom 
		   managedObjectContext:(NSManagedObjectContext *)moc 
  andPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)psc;
@end
