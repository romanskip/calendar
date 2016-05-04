//
//  DetailViewController.h
//  ABCalendar
//
//  Created by Roman Ayala Cordero on 15/08/13.
//  Copyright (c) 2013 Roman Ayala Cordero. All rights reserved.
//

#import <Foundation/Foundation.h>


@class DCDate;

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblCutomerId;
@property (weak, nonatomic) IBOutlet UILabel *lblServiceDate;
@property (nonatomic, strong) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;

@property (nonatomic, strong) DCDate *serviceDate;

@property (nonatomic, copy) void (^dismissBlock) (void);

#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }

- (id) initForNewDate: (BOOL) isNew;

-(IBAction)addNewCustomer:(id)sender;

@end
