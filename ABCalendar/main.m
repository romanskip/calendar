//
//  main.m
//  ABCalendar
//
//  Created by Roman Ayala Cordero on 30/07/13.
//  Copyright (c) 2013 Roman Ayala Cordero. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CygnusAppDelegate.h"
#import <ABCalendarPicker/ABCalendarPicker.h>

int main(int argc, char *argv[])
{
    [ABCalendarPicker class];
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([CygnusAppDelegate class]));
    }
}