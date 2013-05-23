//
//  NegativeTransactionCell.h
//  iBilancio
//
//  Created by Fabio Sassu on 19/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewTransaction;
@interface NegativeTransactionCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *transactionOwner;
@property (nonatomic, strong) IBOutlet UILabel *transactionValue;
@property (nonatomic, strong) IBOutlet UILabel *transactionDate;

-(void) fillWithTransaction: (NewTransaction *) transaction;

@end
