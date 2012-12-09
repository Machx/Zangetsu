/*
//  NSDateAddtions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 3/31/11.
//  Copyright 2012. All rights reserved.
//
 	*/

#import <Foundation/Foundation.h>


@interface NSDate (CWNSDateAddtions)

/**
 Returns a new date object with the same date as the original but n minutes ahead
 
 @param minutes a NSInteger with the number of minutes you want the new date object to advance by
 @param dateCal a NSCalendar object you want to be used for the date calculation or nil if you want [NSCalendar currentCalendar]
 @return a new NSDate object advanced forward by n minutes	*/
-(NSDate *)cw_dateByAddingMinutes:(NSInteger)minutes usingCalendar:(NSCalendar *)dateCal;

/**
 Returns a new date object with the same date as the original but n hours ahead
 
 @param hours a NSInteger with the number of hours you want the new date object to advance by
 @param dateCal a NSCalendar object you want to be used for the date calculation or nil if you want [NSCalendar currentCalendar]
 @return a new NSDate object advanced forward by n hours	*/
-(NSDate *)cw_dateByAddingHours:(NSInteger)hours usingCalendar:(NSCalendar *)dateCal;

/**
 Returns a new date object with the same date as the original but n days ahead
 
 @param days a NSInteger with the number of days you want the new date object to advance by
 @param dateCal a NSCalendar object you want to be used for the date calculation or nil if you want [NSCalendar currentCalendar]
 @return a new NSDate object advanced forward by n days	*/
-(NSDate *)cw_dateByAddingDays:(NSInteger)days usingCalendar:(NSCalendar *)dateCal;

@end
