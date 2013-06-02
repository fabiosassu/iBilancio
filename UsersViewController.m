//
//  UsersViewController.m
//  iBilancio
//
//  Created by Fabio Sassu on 19/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import "UsersViewController.h"
#import "NewUser.h"
#import "NewUserViewController.h"
#import "AppDelegate.h"
#import "User.h"

@interface UsersViewController ()

@end

@implementation UsersViewController
    


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    AppDelegate *app  = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    // Fetch the transactions from persistent data store
    NSManagedObjectContext *managedObjectContext = [app managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    self.users = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableView reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Users";
    [self.navigationItem setHidesBackButton:TRUE];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    [self.navigationItem setLeftBarButtonItem:leftBarButton];
    [leftBarButton release];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewUser:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return @"Users";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    NSLog(@"sel_index= %d",  self.selectedIndex);
    // Configure the cell...
    if (indexPath.row == self.selectedIndex)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[(User*)[self.users objectAtIndex:indexPath.row]name]];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.selectedIndex)
    {
        return NO;
    }
    else
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        AppDelegate *app  = (AppDelegate*)[UIApplication sharedApplication].delegate;
        NSManagedObjectContext *context = [app managedObjectContext];
        [context deleteObject:[self.users objectAtIndex:indexPath.row]];
        [tableView reloadData];
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (IBAction)cancel:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addNewUser:(id)sender {
    NewUserViewController *newUser = [[NewUserViewController alloc]initWithNibName:@"NewUserViewController" bundle:nil];
    [self.navigationController pushViewController:newUser animated:YES];
    [newUser release];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    self.selectedIndex = indexPath.row;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedUser" object:[NSNumber numberWithInt:self.selectedIndex]];
    
    [self.navigationController popViewControllerAnimated:YES];
    [tableView reloadData];
}

@end
