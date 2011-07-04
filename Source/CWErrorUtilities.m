//
//  CWErrorUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/23/10.
//  Copyright 2010. All rights reserved.
//

#import "CWErrorUtilities.h"

//TODO: Remove CWCreateErrorV and put CWCreateErrorV's implementation in CWCreateError

/**
 * Convenience method for creating a NSError Object
 *
 * Easy convenience method to create a NSError Object. It checks for the error message
 * and throws an assertion if it's missing, allows for a string with formatting and 
 * passing arguments for the formatting of a string. If no domain is passed in it defaults
 * to kCWErrorDomain.
 * 
 * @param errorCode a NSInteger for the error code in a NSError object
 * @param domain a NSString specifying the domain for a NSError object
 * @param errorMessageFormat a NSString with optional formatting which specifies the NSError NSLocalizedDescriptionKey
 * @return a NSError object with the values passed in
 */
NSError * CWCreateError(NSInteger errorCode, NSString * domain, NSString * errorMessageFormat, ...){
    NSCParameterAssert(errorMessageFormat);
    NSCParameterAssert(errorCode);

    NSString * _domain;

    if (domain == nil) {
        _domain = kCWErrorDomain;
    } else {
        _domain = domain;
    }	

    va_list args;
    va_start(args, errorMessageFormat);

    NSString * completeErrorMessage = [[NSString alloc] initWithFormat:errorMessageFormat arguments:args];

    va_end(args);

    NSDictionary * _errorDictionary = NSDICT(completeErrorMessage, NSLocalizedDescriptionKey);

    return [NSError errorWithDomain:_domain
                               code:errorCode
                           userInfo:_errorDictionary];
}
