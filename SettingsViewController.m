//
//  SettingsViewController.m
//  iBilancio
//
//  Created by Fabio Sassu on 18/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import "SettingsViewController.h"
#import "BudgetNotificationSelectorViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedIndex:) name:@"selectedBudgetNotification" object:nil];
    [self.budgetNotificationselector reloadData];
}

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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.alertOptions objectAtIndex:[self.selectedIndex integerValue]]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Send me a notification when I reach:";
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
     BudgetNotificationSelectorViewController *detailViewController = [[BudgetNotificationSelectorViewController alloc] initWithNibName:@"BudgetNotificationSelectorViewController" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     detailViewController.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     
}

-(void) selectedIndex:(NSNotification *) obj{
    self.selectedIndex = [obj object];
    
}


@end
