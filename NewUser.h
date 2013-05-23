//
//  NewUser.h
//  iBilancio
//
//  Created by Fabio Sassu on 19/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewUser : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSNumber *isAdmin;

-(id)initWithUserName:(NSString *) userName;

@end
