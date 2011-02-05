//
//  CWDebugUtilities.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/11/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>

BOOL CWIsDebugInProgress(void);
void CWCrash(void);

typedef void (^DebugBlock)(void);
void CWInDebugOnly(DebugBlock block);
uint64_t CWNanoSecondsToExecuteCode(DebugBlock block);

NSString *CWStackTrace(void);
