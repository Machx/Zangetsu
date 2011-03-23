//
//  CWErrorUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/23/10.
//  Copyright 2010. All rights reserved.
//

#import "CWErrorUtilities.h"

/**
 * Easy convenience method to create a NSError Object. It checks for the error message
 * and throws an assertion if it's missing
 */
NSError * CWCreateError(NSInteger errorCode, NSString * domain, NSString * errorMessage){
    return CWCreateErrorV(errorCode, domain, errorMessage);
}

/**
 * Easy convenience method to create a NSError Object. It checks for the error message
 * and throws an assertion if it's missing just like CWCreateError except this one allows
 * for a string with formatting and passing arguments for the formatting of a string
 */
NSError * CWCreateErrorV(NSInteger errorCode, NSString * domain, NSString * errorMessageFormat, ...){
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
