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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    AppDelegate *app  = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    // Fetch the transactions from persistent data store
    NSManagedObjectContext *managedObjectContext = [app managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Transaction"];
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES] autorelease];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    self.transactions = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSLog(@"transaction count: %d", [self.transactions count]);
    
    if ([self.transactions count] == 0) {
    
        NewTransactionViewController *firstTransaction = [[NewTransactionViewController alloc]initWithNibName:@"NewTransactionViewController" bundle:nil];
        firstTransaction.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:firstTransaction animated:YES];
        [firstTransaction release];
    }
    
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTransaction:)] autorelease];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"transactionsBackground.png"]]autorelease];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return self.transactions.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Transaction *transactionz = [self.transactions objectAtIndex:indexPath.row];

    if ([transactionz.value floatValue]>=0.00)
    {
        static NSString *CellIdentifier = @"PositiveTransactionCell";
        PositiveTransactionCell *cell = (PositiveTransactionCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PositiveTransactionCell" owner:self options:nil]objectAtIndex:0];
            Transaction *selected = [self.transactions objectAtIndex:indexPath.row];
            [cell fillWithTransaction:selected];
            
        }   return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"NegativeTransactionCell";
        NegativeTransactionCell *cell = (NegativeTransactionCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"NegativeTransactionCell" owner:self options:nil]objectAtIndex:0];
            Transaction *selected = [self.transactions objectAtIndex:indexPath.row];
            [cell fillWithTransaction:selected];
            
        }   return cell;
    }
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        AppDelegate *app  = (AppDelegate*)[UIApplication sharedApplication].delegate;
        NSManagedObjectContext *context = [app managedObjectContext];
        [context deleteObject:[self.transactions objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
    }
    
}


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

-(IBAction)addTransaction:(id)sender{
    NewTransactionViewController *new = [[NewTransactionViewController alloc]initWithNibName:@"NewTransactionViewController" bundle:nil];
    new.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:new animated:YES];
    [new release];
}

@end
