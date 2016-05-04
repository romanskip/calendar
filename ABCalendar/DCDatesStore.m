//
//  DCDatesStore.m
//  ABCalendar
//
//  Created by Roman Ayala Cordero on 12/08/13.
//  Copyright (c) 2013 Roman Ayala Cordero. All rights reserved.
//

#import "DCDatesStore.h"
#import "DCDate.h"

@interface DCDatesStore(){
    NSMutableArray * _allDates;
}

@end

@implementation DCDatesStore

@synthesize allDates = _allDates;


+ (DCDatesStore *) sharedStore{
    static DCDatesStore *sharedStore = nil;
    
    if (!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];
    
    return sharedStore;
}

-(void)removeDate:(DCDate *)p_serviceDate {
    [_allDates removeObjectIdenticalTo:p_serviceDate];
}

+ (NSArray *) demoList{
    NSString *dbPath = @"/Users/SkIp/Documents/Development/iOs Development/Projects/DogClean/Database/DogClean.sqlite";
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    
    if (![db open]) {
        NSLog(@"Could not open db.");
    }
    
    FMResultSet *rs = [db executeQuery:@"select rowid,* from Clientes"];
    while ([rs next]) {
        
         [[DCDatesStore sharedStore] createDate: [rs stringForColumn:@"Nombre"]];
        
        NSLog(@"%d %@ %@ %@ %@ %@",
              [rs intForColumn:@"Id"],
              [rs stringForColumn:@"Nombre"],
              [rs stringForColumn:@"Calle"],
              [rs stringForColumn:@"Colonia"],
              [rs stringForColumn:@"Ciudad"],
              [rs stringForColumn:@"Estado"]);
    }
    [rs close];
    
    //for (int i = 0; i<5; i++) {
       
    //}
    
    return [[DCDatesStore sharedStore] allDates];
}

+(NSArray *) filterList:(NSDate *)p_ServiceDate{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateStyle:NSDateFormatterShortStyle];
    
    NSString *date1 =[format stringFromDate: p_ServiceDate] ;
    NSMutableArray *filterDates = [[NSMutableArray alloc] init];
    
    for (DCDate *serviceDate in [[DCDatesStore sharedStore] allDates] ) {
     
        NSString *date2 = [format stringFromDate: serviceDate.serviceDate];
        
        if ( ![date1 compare:date2] )
            [filterDates addObject:serviceDate];
    }
    
    if (filterDates.count == 0){ 
        [filterDates addObject:[[DCDate alloc] initWithDate:[[NSDate alloc] init] customerId:@"NO EXISTEN SERVICIOS AGENDADOS"]];
    }
    else{
         DCDate *temp1;
        DCDate *temp;
        NSComparisonResult result;
        
        int i = 0;
        int j;
        
        for (i = 0; i <= (int) (filterDates.count) -2;i++ ){
            for (j = i +1 ; j <= (int) (filterDates.count) -1;j++ ){
                temp1 = [filterDates objectAtIndex:i];
                temp = [filterDates objectAtIndex:j];
               
                result = [temp1.serviceDate compare: temp.serviceDate];
                
                if (result == NSOrderedDescending){
                    [filterDates exchangeObjectAtIndex:i withObjectAtIndex:j];
                }
            }
        }
    }
    
    return[filterDates copy];
    
}

-(id) init{
    self = [super init];
    if(self)
        _allDates = [[NSMutableArray alloc] init];
    
    return self;
}

-(void) moveItemAtIndex:(int)from toIndex:(int)to{
    if (from == to)
        return;
    
    DCDate *p = [_allDates objectAtIndex:from];
    
    [_allDates removeObjectAtIndex:from];
    [_allDates insertObject:p atIndex:to];
}

+(id) allocWithZone:(NSZone *)zone{
    return [self sharedStore];
}

- (DCDate *)createDate:(NSString *) p_customerId{
    DCDate *p = [DCDate getActualDate];
    
    p.customerId = p_customerId;
    
    [_allDates addObject:p];
    return p;
}

- (DCDate *)createDate:(NSString *) p_customerId serviceDate:(NSDate *) p_service_Date{
    DCDate *p = [DCDate getActualDate];
    
    p.serviceDate = p_service_Date;
    p.customerId = p_customerId;
    
    [_allDates addObject:p];
    return p;
}

@end
