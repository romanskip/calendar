//
//  CygnusViewController.m
//  ABCalendar
//
//  Created by Roman Ayala Cordero on 30/07/13.
//  Copyright (c) 2013 Roman Ayala Cordero. All rights reserved.
//

#import "CygnusViewController.h"
#import "DCDate.h"
#import "DCDatesStore.h"

@interface CygnusViewController ()

@end

@implementation CygnusViewController 

@synthesize calendar;
@synthesize books;


-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    
    
    if(self) {
        UINavigationItem *n = [self navigationItem];
        
        [n setTitle:@"Agenda de Dog Clean"];
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewDate:)];
        
        [[self navigationItem] setRightBarButtonItem:bbi];
        
        UIBarButtonItem *bbc = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:@selector(getHome:)];
        
        [[self navigationItem] setLeftBarButtonItem:bbc animated:YES];
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.books count];
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    DCDate *book = [self.books objectAtIndex:indexPath.row];
  
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setTimeStyle:NSDateFormatterShortStyle];
    
      cell.textLabel.text = [NSString stringWithFormat:@"%@ \t \t %@",[format stringFromDate:book.serviceDate],book.customerId];
    cell.detailTextLabel.text = [format stringFromDate:book.serviceDate];
    
    return cell;
}

-(IBAction)addNewDate:(id)sender{
    
    
    DCDate *newItem = [[DCDatesStore sharedStore] createDate:@"Nuevo agregado"  serviceDate:[calendar highlightedDate]];
    
    /*
    DCDate *nilDate;
    BOOL flag = false;
    
     NSMutableArray *dates = [[DCDatesStore filterList:[calendar highlightedDate]] mutableCopy];
    
    DCDate *nonDate = [self.books objectAtIndex:0];
    
    if ( [nonDate.customerId isEqual: @"NO EXISTEN SERVICIOS AGENDADOS"]){
        nilDate = [[DCDate alloc] initWithDate:[[NSDate alloc] init] customerId:@"NO EXISTEN SERVICIOS AGENDADOS"];
        [dates addObject:nilDate];
        
        flag = true;
    }
        
    self.books = [dates copy];
    
    int lastRow = [books indexOfObject:newItem];
    
    NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    [[self tableView] insertRowsAtIndexPaths:@[ip] withRowAnimation:(UITableViewRowAnimationTop)];
    
    if (flag){
        lastRow = [books indexOfObject:nilDate];

        [dates removeObject:nilDate];
        self.books = [dates copy];
    
        ip = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
        [[self tableView] deleteRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationFade];
    }*/
    
    DetailViewController *detailViewController = [[DetailViewController alloc] initForNewDate:YES];
    [detailViewController setServiceDate:newItem];
    
    [detailViewController setDismissBlock:^{
        
        DCDate *nilDate;
        BOOL flag = false;
        
        NSMutableArray *dates = [[DCDatesStore filterList:[calendar highlightedDate]] mutableCopy];
        
        DCDate *nonDate = [self.books objectAtIndex:0];
        
        if ( [nonDate.customerId isEqual: @"NO EXISTEN SERVICIOS AGENDADOS"]){
            nilDate = [[DCDate alloc] initWithDate:[[NSDate alloc] init] customerId:@"NO EXISTEN SERVICIOS AGENDADOS"];
            [dates addObject:nilDate];
            
            flag = true;
        }
        
        self.books = [dates copy];
        
        int lastRow = [books indexOfObject:newItem];
        
        NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRow inSection:0];
        
        [[self tableView] insertRowsAtIndexPaths:@[ip] withRowAnimation:(UITableViewRowAnimationTop)];
        
        if (flag){
            lastRow = [books indexOfObject:nilDate];
            
            [dates removeObject:nilDate];
            self.books = [dates copy];
            
            ip = [NSIndexPath indexPathForRow:lastRow inSection:0];
            
            [[self tableView] deleteRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationFade];
        }
        
        ;}];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    
    [navController setModalPresentationStyle:UIModalPresentationFormSheet];
    [navController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [self presentViewController:navController animated:YES completion:nil];
}

-(void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    [[DCDatesStore sharedStore] moveItemAtIndex:[sourceIndexPath row] toIndex:[destinationIndexPath row]];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        DCDatesStore *menustore = [DCDatesStore sharedStore];
        
        DCDate *menuItem = [books objectAtIndex:[indexPath row]];
        
        [menustore removeDate:menuItem];
        
        books = [menustore allDates];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.books = [DCDatesStore demoList];
}

-(void)calendarPicker:(ABCalendarPicker *)calendarPicker animateNewHeight:(CGFloat)height{

}

-(UIView *) headerView{
    if (!_headerView){
        [[NSBundle mainBundle] loadNibNamed:@"HeaderViewCalendar" owner:self options:nil];
        
        [calendar setState:ABCalendarPickerStateWeekdays animated:TRUE];
        
        [calendar setDelegate:self];
    }
    
    return _headerView;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self headerView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 380;
}

-(void)calendarPicker:(ABCalendarPicker *)calendarPicker willSetState:(ABCalendarPickerState)state fromState:(ABCalendarPickerState)fromState
{

   /* if (state == ABCalendarPickerStateWeekdays)
         [[self tableView] setSectionHeaderHeight:150];
    else
         [[self tableView] setSectionHeaderHeight:600];
    */
    /*self.tableView.tableHeaderView = self.tableView.tableHeaderView ;
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];*/
}

-(void)calendarPicker:(ABCalendarPicker *)calendarPicker dateSelected:(NSDate *)date withState:(ABCalendarPickerState)state{
    
    self.books = [DCDatesStore filterList:date];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)didReceiveMemoryWarning
{
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateStyle:NSDateFormatterShortStyle];
    
    DCDate *newItem = [[DCDatesStore sharedStore] createDate:@"Nuevo agregado"];
    
    self.books = [[DCDatesStore sharedStore] allDates];
    
    int lastRow = [books indexOfObject:newItem];
    
    NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRow inSection:0];
    [[self tableView] insertRowsAtIndexPaths:@[ip] withRowAnimation:(UITableViewRowAnimationTop)];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailViewController *detailViewController = [[DetailViewController alloc] initForNewDate:NO];
    
    //NSArray *services = [[DCDatesStore sharedStore] allDates];
    DCDate *selectedDate = [self.books  objectAtIndex:[indexPath row]];
    
    [detailViewController setServiceDate:selectedDate];
    
    [[self navigationController] pushViewController:detailViewController animated:YES];
    
    /*
    NSArray *items = [[DCDatesStore sharedStore] allDates];
    DCDate *p = [items objectAtIndex:[indexPath row]];
    */
}

@end
