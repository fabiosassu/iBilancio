//
//  BudgetNotificationSelectorViewController.m
//  iBilancio
//
//  Created by Fabio Sassu on 28/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import "BudgetNotificationSelectorViewController.h"

@interface BudgetNotificationSelectorViewController ()

@end

@implementation BudgetNotificationSelectorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"otherBackground.png"]]autorelease];
    
    self.alertOptions = [[NSMutableArray alloc]init];
    
    NSString *zeroBudget = [[NSString alloc]initWithString:@"0% of the budget"];
    NSString *halfBudget = [[NSString alloc]initWithString:@"50% of the budget"];
    NSString *quarterBudget = [[NSString alloc]initWithString:@"25% of the budget"];
    NSString *seventyFiveBudget = [[NSString alloc]initWithString:@"75% of the budget"];
    
    [self.alertOptions addObject:zeroBudget];
    [self.alertOptions addObject:quarterBudget];
    [self.alertOptions addObject:halfBudget];
    [self.alertOptions addObject:seventyFiveBudget];
    
    [zeroBudget release];
    [halfBudget release];
    [quarterBudget release];
    [seventyFiveBudget release];
    
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
    return [self.alertOptions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if (indexPath.row == self.selectedIndex)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.alertOptions objectAtIndex:indexPath.row]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Send me a notification when I reach:";
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
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedBudgetNotification" object:[NSNumber numberWithInt:self.selectedIndex]];
    
    [self.navigationController popViewControllerAnimated:YES];
    [tableView reloadData];
}

@end
