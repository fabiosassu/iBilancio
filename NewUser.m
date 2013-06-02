//
//  NewUser.m
//  iBilancio
//
//  Created by Fabio Sassu on 19/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import "NewUser.h"

@implementation NewUser

-(id)initWithUserName:(NSString *) userName {
    if (self =[super init]) {
        self.userName = userName;
    } return self;
}

@end
