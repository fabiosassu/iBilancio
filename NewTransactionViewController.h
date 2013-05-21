//
//  NewTransactionViewController.h
//  iBilancio
//
//  Created by Fabio Sassu on 19/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface NewTransactionViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UILabel *valueLabel;
@property (nonatomic, strong) IBOutlet UIButton *nextDay;
@property (nonatomic, strong) IBOutlet UIButton *previousDay;
@property (nonatomic, strong) IBOutlet UIButton *calendarButton;
@property (nonatomic, strong) IBOutlet UIButton *valueButton;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic) float selectedValue;
@property (nonatomic, strong) NSMutableArray *totalUsers;

- (IBAction)valueButtonPressed:(id)sender;
- (IBAction)nextDayButtonPressed:(id)sender;
- (IBAction)previousDayButtonPressed:(id)sender;
- (IBAction)calendarButtonPressed:(id)sender;

@end
