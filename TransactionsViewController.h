//
//  TransactionsViewController.h
//  iBilancio
//
//  Created by Fabio Sassu on 18/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface TransactionsViewController : UITableViewController 

@property (strong) NSMutableArray *transactions;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
