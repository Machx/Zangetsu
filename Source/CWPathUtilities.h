/*
//  CWPathUtilities.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/20/10.
//  Copyright 2010. All rights reserved.
//
 	*/

#import <Foundation/Foundation.h>

/**
 Returns the expanded path from a tilde string ex '~/Documents/Stuff/a.txt'
 
 Retuns a NSString with the expanded path if it exists, otherwise it returns nil.
 
 @param tildePath a NSString with a tilde path
 @return a NSString with the expanded tilde path if it exists, otherwise nil	*/
NSString *CWFullPathFromTildeString(NSString *tildePath);

@interface CWPathUtilities : NSObject
/**	Conveince method for returing the apps Application Support folder
 * 
 * Gets the application support folder path & appends the bundle name to get the app support folder path
 * for the application its being used in. The path returned is not guaranteed to exist.
 * 
 * @return a NSString with the Application Support Folder Path for this application	*/
+(NSString *)applicationSupportFolder;

/**	Convenience method for returning a path including a subpath (path) in the app support folder
 *
 * Returns the path including a subpath in the application support folder for the current app. The
 * path returned is not guaranteed to exist. 
 *
 * @param path a subpath to be appended on to the Application Support Folder Path
 * @return a NSString with the path within the app support folder path to the specified sub path	*/
+(NSString *)pathByAppendingAppSupportFolderWithPath:(NSString *)path;

/**	Convenience method for returning the path for a document in the Documents folder
 *
 * Returns the document file path for a document in the users document folder. The path 
 * returned is not guaranteed to exist. If file is nil then this api will throw an assertion.
 *
 * @param file the file in the document folder you are getting a path to
 * @return a NSString with the path to file inside the documents folder.	*/
+(NSString *)documentsFolderPathForFile:(NSString *)file;

/**	Convenience Method for returning a subpath within the home folder path
 *
 * Returns the home folder path with a subpath appended onto the home folder path
 *
 * @param subpath the path to be appended onto the home folder path
 * @return a NSString with the path within the home folder path	*/
+(NSString *)pathByAppendingHomeFolderPath:(NSString *)subPath;

/**
 Returns a NSString path to a temporary file
 
 Uses NSTemporaryDirectory() and the cw_uuidString method to create a unique
 path for a temporary file. 
 
 @return a NSString with the full path to a temporary file with a unique name and .temp extension	*/
+(NSString *)temporaryFilePath;
@end
