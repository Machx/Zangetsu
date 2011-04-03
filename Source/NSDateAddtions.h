//
//  NSDateAddtions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 3/31/11.
//  Copyright 2011. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (CWNSDateAddtions)

-(NSDate *)cw_dateByAddingHours:(NSUInteger)hours;

-(NSDate *)cw_dateByAddingDays:(NSUInteger)days;

@end
