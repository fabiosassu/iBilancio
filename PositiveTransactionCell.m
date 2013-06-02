//
//  PositiveTransactionCell.m
//  iBilancio
//
//  Created by Fabio Sassu on 19/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import "PositiveTransactionCell.h"
#import "Transaction.h"

@implementation PositiveTransactionCell

-(void) fillWithTransaction: (Transaction *) transaction{
    
    self.transactionOwner.text = [NSString stringWithFormat:@"%@",transaction.isMadeBy.name];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    self.transactionDate.text = [df stringFromDate:transaction.date];
    [df release];
    self.transactionValue.text = [NSString stringWithFormat:@"%.2f",[transaction.value doubleValue]];
    
}

@end
