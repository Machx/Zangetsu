//
//  CWExceptionUtilities.h
//  Zangetsu
//
//  Created by Colin Wheeler on 1/29/11.
//  Copyright 2011. All rights reserved.
//

#import <Cocoa/Cocoa.h>

void CWReportException(NSException *exception);

void CWShowExceptionAsAlertPanel(NSException *exception);

@interface NSException (CWNSExceptionAdditions)

-(NSString *)cw_stackTrace;

@end

