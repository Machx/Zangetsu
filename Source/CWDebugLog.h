/*
 *  CWDebugLog.h
 *  RedFlag
 *
 *  Created by Colin Wheeler on 2/2/09.
 *  Copyright 2009 Niblonian Soft. All rights reserved.
 *
 */

/* many thanks to Marcus Zarra for this code! */

#ifdef DEBUG
#    define DebugLog(...) NSLog(__VA_ARGS__)
#else
#    define DebugLog(...) /* */
#endif
#define ALog(...) NSLog(__VA_ARGS__)