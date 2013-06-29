/*
//  CWPathUtilities.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/20/10.
//  Copyright 2010. All rights reserved.
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

/**
 Returns the expanded path from a tilde string ex '~/Documents/Stuff/a.txt'
 
 Retuns a NSString with the expanded path if it exists, otherwise it returns nil.
 
 @param tildePath a NSString with a tilde path
 @return a NSString with the expanded tilde path if it exists, otherwise nil
 */
NSString *CWFullPathFromTildeString(NSString *tildePath);

@interface CWPathUtilities : NSObject
/**
  Conveince method for returing the apps Application Support folder
  
  Gets the application support folder path & appends the bundle name to get the
  app support folder path for the application its being used in. The path 
  returned is not guaranteed to exist.
  
  @return NSString with the Application Support Folder Path for this application
 */
+(NSString *)applicationSupportFolder;

/**
 Returns a path including a subpath (path) in the app support folder
 
 Returns the path including a subpath in the application support folder for the
 current app. The path returned is not guaranteed to exist. 
 
 @param path a subpath to be appended on to the Application Support Folder Path
 @return NSString with path within the app support folder path to the subpath
 */
+(NSString *)pathByAppendingAppSupportFolderWithPath:(NSString *)path;

/**
  Returns the path for a document in the Documents folder
 
 Returns the document file path for a document in the users document folder.
 The path returned is not guaranteed to exist. If file is nil then this api will
 throw an assertion.
 
 @param file the file in the document folder you are getting a path to
 @return a NSString with the path to file inside the documents folder.
 */
+(NSString *)documentsFolderPathForFile:(NSString *)file;

/**
  Convenience Method for returning a subpath within the home folder path
 
  Returns the home folder path with a subpath appended onto the home folder path
 
  @param subpath the path to be appended onto the home folder path
  @return a NSString with the path within the home folder path
 */
+(NSString *)pathByAppendingHomeFolderPath:(NSString *)subPath;

/**
 Returns a NSString path to a temporary file
 
 Uses NSTemporaryDirectory() and the cw_uuidString method to create a unique
 path for a temporary file.
 
 @return NSString with the full path to a temporary file with a unique name
 */
+(NSString *)temporaryFilePath;
@end
