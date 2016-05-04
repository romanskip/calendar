//
//  DCDate.m
//  ABCalendar
//
//  Created by Roman Ayala Cordero on 12/08/13.
//  Copyright (c) 2013 Roman Ayala Cordero. All rights reserved.
//

#import "DCDate.h"

@implementation DCDate

@synthesize customerId;
@synthesize serviceDate;

-(id) initWithDate:(NSDate *)p_serviceDate{
    self = [super init];
    
    if(self){
        serviceDate = p_serviceDate;
    }
    
    return self;
}

-(id) initWithDate:(NSDate *)p_serviceDate customerId:(NSString *)p_customerId{
    self = [super init];
    
    if (self){
        serviceDate = p_serviceDate;
        customerId = p_customerId;
    }
        
    return self;
}

-(NSString *) getServiceDateToString{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateStyle:NSDateFormatterShortStyle];
    
    return  [formater stringFromDate:serviceDate];
}

+(id) getActualDate{
    DCDate *actualDate = [[DCDate alloc] init];
    
    actualDate.serviceDate = [[NSDate alloc] init];
    
    return actualDate;
}

@end
