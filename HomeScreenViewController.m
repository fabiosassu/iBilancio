//
//  HomeScreenViewController.m
//  iBilancio
//
//  Created by Fabio Sassu on 18/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "TransactionsViewController.h"
#import "BudgetViewController.h"
#import "SettingsViewController.h"
#import "HelpViewController.h"

@interface HomeScreenViewController ()

@end

@implementation HomeScreenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

-(IBAction)transactionButtonPressed:(id)sender{
    
    TransactionsViewController *next = [[TransactionsViewController alloc] initWithNibName:@"TransactionsViewController" bundle:nil];
    [self.navigationController pushViewController:next animated:YES];
    [next release];
    
}

-(IBAction)budgetButtonPressed:(id)sender{
 
    BudgetViewController *next = [[BudgetViewController alloc] initWithNibName:@"TabBarViewController" bundle:nil];
    [self.navigationController pushViewController:next animated:YES];
    [next release];
    
}

-(IBAction)settingsButtonPressed:(id)sender{
    
    SettingsViewController *next = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController.h" bundle:nil];
    [self.tabBarController.navigationController pushViewController:next animated:YES];
    [next release];
    
}

-(IBAction)helpButtonPressed:(id)sender{
    HelpViewController *helpPage = [[HelpViewController alloc]initWithNibName:@"HelpViewController" bundle:nil];
    [self.navigationController pushViewController:helpPage animated:YES];
    [helpPage release];
}

@end
