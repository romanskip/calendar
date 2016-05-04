//
//  DCDate.h
//  ABCalendar
//
//  Created by Roman Ayala Cordero on 12/08/13.
//  Copyright (c) 2013 Roman Ayala Cordero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCDate : NSObject

@property NSString *customerId;
@property NSDate *serviceDate;

-(id) initWithDate: (NSDate *) p_serviceDate;
-(id) initWithDate:(NSDate *) p_serviceDate
        customerId: (NSString *) p_customerId;
-(NSString *) getServiceDateToString;

+(id) getActualDate;

@end
