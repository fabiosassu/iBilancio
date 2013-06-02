//
//  NewTransactionViewController.m
//  iBilancio
//
//  Created by Fabio Sassu on 19/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import "NewTransactionViewController.h"
#import "NewTransaction.h"
#import "NewUser.h"
#import "User.h"
#import "Transaction.h"
#import "CalendarViewController.h"
#import "UsersViewController.h"
#import "AppDelegate.h"
#import "TValueViewController.h"
#import "ReminderViewController.h"

@interface NewTransactionViewController ()

@end

@implementation NewTransactionViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseFloat:) name:@"selectedValue" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSign:) name:@"positivo" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUser:) name:@"selectedUser" object:nil];
    
    [self.tableView reloadData];
    
    if (self.reminderSwitch.on)
    {
        [self.reminderTableView reloadData];
    }
    
    self.valueLabel.text = [NSString stringWithFormat:@"%8.2f",self.selectedValue];
    
    if(self.selectedValue != 0.0){
    if (self.positivo)
    {
        UIImage *button = [UIImage imageNamed:@"plusLabel"];
        [self.valueButton setImage:button forState:0];
    }
    else
    {
        UIImage *button = [UIImage imageNamed:@"minusLabel"];
        [self.valueButton setImage:button forState:0];
    }
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"New Transaction";
    
    [self.navigationItem setHidesBackButton:TRUE];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    [self.navigationItem setLeftBarButtonItem:leftBarButton];
    [leftBarButton release];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveTransaction:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    [rightBarButton release];
    
    self.view.backgroundColor = [[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"otherBackground.png"]]autorelease];
    
    self.valueLabel.text = [NSString stringWithFormat:@"%8.2f",self.selectedValue];
    
    AppDelegate *app  = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    // Fetch the transactions from persistent data store
    NSManagedObjectContext *managedObjectContext = [app managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    self.totalUsers = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    if ([self.totalUsers count] == 0)
    {
        AppDelegate *app  = (AppDelegate*)[UIApplication sharedApplication].delegate;
        
        NSManagedObjectContext *context = [app managedObjectContext];
        
        NewUser *firstUser = [[NewUser alloc]initWithUserName:@"Me"];
        firstUser.isAdmin = [NSNumber numberWithInt:1];
        
        User *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
        
        // If appropriate, configure the new managed object.
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
        [newUser setValue:firstUser.userName forKey:@"name"];
        [newUser setValue:firstUser.isAdmin forKey:@"isAdmin"];
        [firstUser release];
        // Save the context.
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
            [self.tableView reloadData];
    }
    
    self.selectedDate = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    self.dateLabel.text = [df stringFromDate:self.selectedDate];
    [df release];
    
    [self.tableView reloadData];
     
}

-(void) parseFloat:(NSNotification *) obj{
    self.selectedValue = [[obj object] doubleValue];
    
}

-(void) getSign:(NSNotification *) obj{
    self.positivo = [[obj object] boolValue];
    
}

-(void) setUser:(NSNotification *) obj{
    self.selectedUser = [[obj object]integerValue];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *header = nil;
    
    if (tableView==self.tableView)
    {
        header = @"User:";
    }
    else if (tableView==self.reminderTableView)
    {
        header = @"The transaction occurs every:";
    }
    return header;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if (tableView==self.tableView)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[(User*)[self.totalUsers objectAtIndex:self.selectedUser]name]];
    }
    else
    {
        cell.textLabel.text = @"Never";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tableView)
    {
        
     UsersViewController *detailViewController = [[UsersViewController alloc] initWithNibName:@"UsersViewController" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     detailViewController.selectedIndex = self.selectedUser;
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
    }
    else
    {
        ReminderViewController *detailViewController = [[ReminderViewController alloc] initWithNibName:@"ReminderViewController" bundle:nil];
        // ...
        // Pass the selected object to the new view controller.
        [self.navigationController pushViewController:detailViewController animated:YES];
        [detailViewController release];
    }
    
}

- (IBAction)nextDayButtonPressed:(id)sender{
    
    self.selectedDate = [NSDate dateWithTimeInterval:86400 sinceDate:self.selectedDate];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    self.dateLabel.text = [df stringFromDate:self.selectedDate];
    [df release];
}

- (IBAction)previousDayButtonPressed:(id)sender{
    
    self.selectedDate = [NSDate dateWithTimeInterval:-86400 sinceDate:self.selectedDate];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    self.dateLabel.text = [df stringFromDate:self.selectedDate];
    [df release];
    
}

- (IBAction)valueButtonPressed:(id)sender{
    
    TValueViewController *callController = [[TValueViewController alloc]initWithNibName:@"TValueViewController" bundle:nil];
    [self.navigationController pushViewController:callController animated:YES];
    [callController release];
    
}

- (IBAction)cancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveTransaction:(id)sender {
    
    AppDelegate *app  = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *context = [app managedObjectContext];
    
    Transaction *newTransaction = [NSEntityDescription insertNewObjectForEntityForName:@"Transaction" inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newTransaction setValue:self.selectedDate forKey:@"date"];
    if(!self.positivo)
        self.selectedValue *= -1;
    [newTransaction setValue:[NSNumber numberWithDouble:self.selectedValue] forKey:@"value"];
    [newTransaction setValue:[self.totalUsers objectAtIndex:self.selectedUser] forKey:@"isMadeBy"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)calendarButtonPressed:(id)sender{
    
    CalendarViewController *callCalendar = [[CalendarViewController alloc]initWithNibName:@"CalendarViewController" bundle:nil];
    [self.navigationController pushViewController:callCalendar animated:YES];
    [callCalendar release];
}

-(IBAction)advancedSwitchOn:(id)sender
{
    if (self.advancedOptionsSwitch.on)
    {
        self.reminderLabel.hidden = NO;
        self.reminderSwitch.hidden = NO;
    }
    else
    {
        self.reminderLabel.hidden = YES;
        self.reminderSwitch.hidden = YES;
        self.reminderTableView.hidden = YES;
        self.scrollView.contentSize = CGSizeMake(320, 548);
        self.scrollView.scrollEnabled = NO;
    }
}

-(IBAction)reminderSwitchOn:(id)sender
{
    if (self.reminderSwitch.on)
    {
        self.reminderTableView.hidden = NO;
        self.scrollView.contentSize = CGSizeMake(320, 590);
        self.scrollView.scrollEnabled = YES;
    }
    else
    {
        self.reminderTableView.hidden = YES;
        self.scrollView.contentSize = CGSizeMake(320, 548);
        self.scrollView.scrollEnabled = NO;
    }
}

@end
