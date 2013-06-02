//
//  NewBudgetViewController.h
//  iBilancio
//
//  Created by Fabio Sassu on 28/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewBudgetViewController : UIViewController

@property (nonatomic,strong) IBOutlet UITextField *budgetName;
@property (nonatomic,strong) IBOutlet UIButton *budgetAmount;
@property (nonatomic,strong) IBOutlet UITableView *usersTableView;
@property (nonatomic,strong) IBOutlet UILabel *valueLabel;

@property (nonatomic) double selectedValue;
@property (nonatomic, strong) NSMutableArray *totalUsers;
@property (nonatomic) NSInteger selectedUser;

@end
