//
//  DetailViewController.m
//  ABCalendar
//
//  Created by Roman Ayala Cordero on 15/08/13.
//  Copyright (c) 2013 Roman Ayala Cordero. All rights reserved.
//

#import "DetailViewController.h"
#import "DCDate.h"
#import "DCDatesStore.h"

@implementation DetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    DCDate *service = [self serviceDate];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateStyle:NSDateFormatterMediumStyle];
    
    [self.lblServiceDate setText: [format stringFromDate:service.serviceDate]];
    [self.lblCutomerId setText:service.customerId];

    
    [self.timePicker setDatePickerMode:UIDatePickerModeTime];
    
    [self.timePicker setMinuteInterval:30];
    
        [self.timePicker setDate:service.serviceDate animated:YES];
    
}

-(void) setServiceDate:(DCDate *)serviceDate{
    _serviceDate = serviceDate;
    [[self navigationItem] setTitle:_serviceDate.customerId];
}

-(id) initForNewDate:(BOOL)isNew{
    self = [super initWithNibName:@"DetailViewController" bundle:nil];
    
    if (self) {
        if (isNew) {
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
            
            [[self navigationItem] setRightBarButtonItem:doneItem];
            
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
            
            [[self navigationItem] setLeftBarButtonItem:cancelItem];
        }
    }
    
    return self;
}

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    @throw [NSException exceptionWithName:@"Wrong initializer" reason:@"Use initForNewDate" userInfo:nil];
    
    return nil;
}


- (IBAction)addNewCustomer:(id)sender{
    


}

-(void) save:(id) sender{
    [[self serviceDate] setServiceDate:[[self timePicker] date] ];
    
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:[self dismissBlock]];
}

-(void) cancel: (id) sender{
    [[DCDatesStore sharedStore] removeDate:[self serviceDate]];
    
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

@end
