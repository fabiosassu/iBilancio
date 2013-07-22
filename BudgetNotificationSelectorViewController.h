//
//  BudgetNotificationSelectorViewController.h
//  iBilancio
//
//  Created by Fabio Sassu on 28/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BudgetNotificationSelectorViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray *alertOptions;
@property (nonatomic) int selectedIndex;

@end
