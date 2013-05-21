//
//  PositiveTransactionCell.m
//  iBilancio
//
//  Created by Fabio Sassu on 19/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import "PositiveTransactionCell.h"
#import "NewTransaction.h"

@implementation PositiveTransactionCell

-(void) fillWithTransaction: (NewTransaction *) transaction{
    
    self.transactionOwner.text = [NSString stringWithFormat:@"%@",transaction.userName];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd:MM:yyyy"];
    self.transactionDate.text = [df stringFromDate:transaction.transactionDate];
    [df release];
    self.transactionValue.text = [NSString stringWithFormat:@"%.2f",transaction.transactionValue];
    
    
}

@end
