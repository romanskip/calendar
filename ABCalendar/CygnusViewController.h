//
//  CygnusViewController.h
//  ABCalendar
//
//  Created by Roman Ayala Cordero on 30/07/13.
//  Copyright (c) 2013 Roman Ayala Cordero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ABCalendarPicker/ABCalendarPicker.h>
#import "DetailViewController.h"


@interface CygnusViewController : UITableViewController <ABCalendarPickerDelegateProtocol>

@property (nonatomic,strong) IBOutlet ABCalendarPicker *calendar;
@property (nonatomic, strong) IBOutlet UIView *headerView;

@property (nonatomic, copy) NSArray *books;

-(IBAction)addNewDate:(id)sender;

@end
