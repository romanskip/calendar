//
//  CustomerViewController.m
//  ABCalendar
//
//  Created by SkIp on 17/06/14.
//  Copyright (c) 2014 Roman Ayala Cordero. All rights reserved.
//

#import "CustomerViewController.h"

@interface CustomerViewController ()

@end

@implementation CustomerViewController

- (id) initForNewCustomer: (BOOL) isNew{
    self = [super initWithNibName:@"CustomerViewController" bundle:nil];
    
    if (self){
        if (isNew){
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
            
            [[self navigationItem] setRightBarButtonItem:doneItem];
            
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
            
            [[self navigationItem] setLeftBarButtonItem:cancelItem];
        }
    }
    
    return nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    
    
    if(self) {
        UINavigationItem *n = [self navigationItem];
        
        [n setTitle:@"Cliente"];
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewDate:)];
        
        [[self navigationItem] setRightBarButtonItem:bbi];
        
        UIBarButtonItem *bbc = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(getHome:)];
        
        [[self navigationItem] setLeftBarButtonItem:bbc animated:YES];
    }
    
    return self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
