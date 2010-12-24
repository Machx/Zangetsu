//
//  CWErrorUtilities.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/23/10.
//  Copyright 2010. All rights reserved.
//

#import "CWErrorUtilities.h"

NSError* CWCreateError(NSInteger errorCode, NSString *domain, NSString *errorMessage)
{
	NSString *_domain;
	if(domain == nil){
		_domain = kCWErrorDomain;
	} else {
		_domain = domain;
	}
	
	NSDictionary *_errorDictionary = NSDICT(errorMessage,NSLocalizedDescriptionKey);
	
	return [NSError errorWithDomain:_domain
							   code:errorCode
						   userInfo:_errorDictionary];
}
