//
//  Budget.h
//  iBilancio
//
//  Created by Fabio Sassu on 28/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "User.h"


@interface Budget : User

@property (nonatomic, retain) NSNumber * amount;

@end
