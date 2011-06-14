//
//  CWGraphicsFoundation.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/24/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NSRect CWCenterRect(NSRect smallRect, NSRect largeRect);

extern CGContextRef CWCurrentCGContext();

typedef void (^ContextBlock)(void);
void CWExecuteAndRestoreCGContext(CGContextRef context,ContextBlock);

extern void CWAddRoundedRectToPath(CGContextRef context,
								   CGRect rect,
								   float ovalWidth,
								   float ovalHeight);
