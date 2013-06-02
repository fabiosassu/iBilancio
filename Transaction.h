//
//  Transaction.h
//  iBilancio
//
//  Created by Fabio Sassu on 21/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "User.h"

@interface Transaction : User

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * value;
@property (nonatomic, retain) User *isMadeBy;

@end
