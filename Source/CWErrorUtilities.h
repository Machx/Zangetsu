/*
//  CWErrorUtilities.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/23/10.
//  Copyright 2010. All rights reserved.
//
 	*/

#import <Foundation/Foundation.h>

#define CWLogError(_error_) NSLog(@"%@",[_error_ description])

static NSString * const kCWErrorDomain = @"CWErrorDomain";

/**
 Convenience method for creating a NSError Object
 
 Easy convenience method to create a NSError Object. It checks for the error 
 message and throws an assertion if it's missing, allows for a string with 
 formatting and passing arguments for the formatting of a string. If no domain 
 is passed in it defaults to kCWErrorDomain.
 
 @param domain a NSString specifying the domain for a NSError object
 @param errorCode a NSInteger for the error code in a NSError object
<<<<<<< HEAD
 @param errorMessageFormat a NSString with optional formatting which specifies the NSError NSLocalizedDescriptionKey
 @return a NSError object with the values passed in	*/
NSError * CWCreateError(NSString * domain, NSInteger errorCode, NSString * errorMessageFormat, ...);
=======
 @param errorMessageFormat a string format which sets NSLocalizedDescriptionKey
 @return a NSError object with the values passed in
 */
NSError * CWCreateError(NSString * domain,
						NSInteger errorCode,
						NSString * errorMessageFormat, ...);
>>>>>>> upstream/master

/**
 Convenience method for creating a NSError Object
 
 Easy convenience method to create a NSError Object. This method is similar to 
 CWCreateError(), but it also allows setting userInfo dictionary entries. 
 It checks for the error message and throws an assertion if it's missing, allows
 for a string with formatting and passing arguments for the formatting of a
 string. If no domain is passed in it defaults to kCWErrorDomain.
 
 @param domain a NSString specifying the domain for a NSError object
 @param errorCode a NSInteger for the error code in a NSError object
<<<<<<< HEAD
 @param info a NSDictionary with any other key/value pairs to be added to the NSError object
 @param errorMessageFormat a NSString with optional formatting which specifies the NSError NSLocalizedDescriptionKey
 @return a NSError object with the values passed in	*/
NSError * CWCreateErrorWithUserInfo(NSString * domain, NSInteger errorCode, NSDictionary *info, NSString * errorMessageFormat, ...);
=======
 @param info a dictionary to be added to the error
 @param errorMessageFormat string formatting for NSLocalizedDescriptionKey
 @return a NSError object with the values passed in
 */
NSError * CWCreateErrorWithUserInfo(NSString * domain,
									NSInteger errorCode,
									NSDictionary *info,
									NSString * errorMessageFormat, ...);
>>>>>>> upstream/master

/**
 Convenience Method for logging NSError information directly
 
 Internally this method does what you would have to do manually to log an
 NSError object to the console. It creates a NSError object and then logs its 
 description with CWLogError().
 
 @param domain a NSString specifying the domain for a NSError object
 @param errorCode a NSInteger for the error code in a NSError object
<<<<<<< HEAD
 @param errorMessageFormat a NSString with optional formatting which specifies the NSError NSLocalizedDescriptionKey	*/
void CWLogErrorInfo(NSString * domain, NSInteger errorCode, NSString * errorMessageFormat, ...);
=======
 @param errorMessageFormat string formatting for NSLocalizedDescriptionKey
 */
void CWLogErrorInfo(NSString * domain,
					NSInteger errorCode,
					NSString * errorMessageFormat, ...);

/**
 Safely Sets an error by checking if it is non nil
 
 This allows creating an error and safely setting it wihtout worrying about 
 checking for non nil value before setting the pointer. 
 
 @param domain a NSString specifying the domain for a NSError object
 @param errorCode a NSInteger for the error code in a NSError object
 @param errorMessageFormat string formatting for NSLocalizedDescriptionKey
 @param error the NSError reference to set
 */
void CWErrorSet(NSString *domain,
				NSInteger errorCode,
				NSString *errorMessageFormat,
				NSError **error);

/**
 Safely Sets an error by checking if it is non nil
 
 This allows creating an error and safely setting it wihtout worrying about
 checking for non nil value before setting the pointer. This method also allows
 you to set additional values in the user info dictionary if needed.
 
 @param domain a NSString specifying the domain for a NSError object
 @param errorCode a NSInteger for the error code in a NSError object
 @param errorMessageFormat string formatting for NSLocalizedDescriptionKey
 @param error the NSError reference to set
 */
void CWErrorSetV(NSString *domain,
				 NSInteger errorCode,
				 NSString *errorMessageFormat,
				 NSDictionary *userInfo,
				 NSError **error);

/**
 Tests if the condition is true and if it is sets the error
 
 @param cond the condition to be tested
 @param errorBlock a block that returns a NSError object if the error is set
 @param error pointer to be set with the block returned var if condition is true
 @return returns YES if the condition evaluates to true, otherwise returns NO
 */
BOOL CWErrorTrap(BOOL cond,
				NSError *(^errorBlock)(void),
				NSError **error);
>>>>>>> upstream/master
