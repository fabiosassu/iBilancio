//
//  NewTransaction.h
//  iBilancio
//
//  Created by Fabio Sassu on 21/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import "NewUser.h"

@interface NewTransaction : NewUser

@property (nonatomic, strong) NSNumber *transactionValue;
@property (nonatomic, strong) NSDate *transactionDate;
@property (nonatomic, strong) NSString *transactionCategory;

@end
