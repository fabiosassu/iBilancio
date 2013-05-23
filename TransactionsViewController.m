//
//  TransactionsViewController.m
//  iBilancio
//
//  Created by Fabio Sassu on 18/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import "TransactionsViewController.h"
#import "NewTransactionViewController.h"
#import "PositiveTransactionCell.h"
#import "NegativeTransactionCell.h"
#import "AppDelegate.h"
#import "Transaction.h"

@interface TransactionsViewController ()

@end

@implementation TransactionsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTransaction:)] autorelease];
    self.navigationItem.rightBarButtonItem = addButton;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    AppDelegate *app  = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    // Fetch the transactions from persistent data store
    NSManagedObjectContext *managedObjectContext = [app managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Transaction"];
    self.transactions = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableView reloadData];
    
    if (self.transactions.count == 0) {
        
        NewTransactionViewController *firstTransaction = [[NewTransactionViewController alloc]initWithNibName:@"NewTransactionViewController" bundle:nil];
        [self.navigationController pushViewController:firstTransaction animated:YES];
        [firstTransaction release];
    }
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
    return _transactions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Transaction *transactions = [self.transactions objectAtIndex:indexPath.row];
    if (transactions.value>0)
    {
        static NSString *CellIdentifier = @"PositiveTransactionCell";
        PositiveTransactionCell *cell = (PositiveTransactionCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PositiveTransactionCell" owner:self options:nil]objectAtIndex:0];
            NewTransaction *selected = [self.transactions objectAtIndex:indexPath.row];
            [cell fillWithTransaction:selected];
            
        }   return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"NegativeTransactionCell";
        NegativeTransactionCell *cell = (NegativeTransactionCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"NegativeTransactionCell" owner:self options:nil]objectAtIndex:0];
            NewTransaction *selected = [self.transactions objectAtIndex:indexPath.row];
            [cell fillWithTransaction:selected];
            
        }   return cell;
    }   
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [[object valueForKey:@"timeStamp"] description];
}

-(IBAction)addTransaction:(id)sender{
    NewTransactionViewController *new = [[NewTransactionViewController alloc]initWithNibName:@"NewTransactionViewController" bundle:nil];
    [self.navigationController pushViewController:new animated:YES];
    [new release];
}

@end
