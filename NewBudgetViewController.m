//
//  NewBudgetViewController.m
//  iBilancio
//
//  Created by Fabio Sassu on 28/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import "NewBudgetViewController.h"
#import "AppDelegate.h"
#import "Budget.h"
#import "TValueViewController.h"
#import "User.h"

@interface NewBudgetViewController ()

@end

@implementation NewBudgetViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseFloat:) name:@"selectedValue" object:nil];

    AppDelegate *app  = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    // Fetch the transactions from persistent data store
    NSManagedObjectContext *managedObjectContext = [app managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    self.totalUsers = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    
    [self.usersTableView reloadData];
    
    self.valueLabel.text = [NSString stringWithFormat:@"%8.2f",self.selectedValue];
    
    if (self.selectedValue > 0)
    {
        UIImage *button = [UIImage imageNamed:@"plusLabel"];
        [self.budgetAmount setImage:button forState:0];
    }
    if (self.selectedValue < 0)
    {
        UIImage *button = [UIImage imageNamed:@"minusLabel"];
        [self.budgetAmount setImage:button forState:0];
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"New Budget";
    
    [self.navigationItem setHidesBackButton:TRUE];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    [self.navigationItem setLeftBarButtonItem:leftBarButton];
    [leftBarButton release];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveBudget:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    [rightBarButton release];
    
    self.view.backgroundColor = [[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"otherBackground.png"]]autorelease];
    
}

-(void) parseFloat:(NSNotification *) obj{
    self.selectedValue = [[obj object] doubleValue];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return self.totalUsers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if (indexPath.row == self.selectedUser)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[(User*)[self.totalUsers objectAtIndex:indexPath.row]name]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"User's budget:";
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedUser = indexPath.row;
    [tableView reloadData];
    // Navigation logic may go here. Create and push another view controller.
    
    
    
}

- (IBAction)cancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveBudget:(id)sender {
        
        AppDelegate *app  = (AppDelegate*)[UIApplication sharedApplication].delegate;
        
        NSManagedObjectContext *context = [app managedObjectContext];
        
        Budget *newBudget = [NSEntityDescription insertNewObjectForEntityForName:@"Budget" inManagedObjectContext:context];
        NSString *tmp = [[NSString alloc]initWithFormat:@"%@",self.budgetName.text];
        // If appropriate, configure the new managed object.
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
        [newBudget setValue:tmp forKey:@"name"];
        [newBudget setValue:[NSNumber numberWithDouble:self.selectedValue] forKey:@"amount"];
        [newBudget setValue:[self.totalUsers objectAtIndex:self.selectedUser] forKey:@"isMadeBy"];
        [tmp release];
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

-(IBAction)budgetAmountSelector:(id)sender
{
    TValueViewController *amountSelector = [[TValueViewController alloc]initWithNibName:@"TValueViewController" bundle:nil];
    [self.navigationController pushViewController:amountSelector animated:YES];
    [amountSelector release];
}

@end
