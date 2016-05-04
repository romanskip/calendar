//
//  DCDatesStore.h
//  ABCalendar
//
//  Created by Roman Ayala Cordero on 12/08/13.
//  Copyright (c) 2013 Roman Ayala Cordero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@class DCDate;

@interface DCDatesStore : NSObject


+ (DCDatesStore *) sharedStore;
+ (NSArray *) demoList;
+(NSArray *) filterList:(NSDate *)serviceDate;

@property (nonatomic, strong, readonly) NSArray *allDates;
-(DCDate *) createDate: (NSString *) p_customerId;
-(DCDate *) createDate: (NSString *) p_customerId serviceDate: (NSDate *) p_serviceDate;
-(void)removeDate: (DCDate *) p_serviceDate;
-(void) moveItemAtIndex:(int) from toIndex:(int) to;

@end
