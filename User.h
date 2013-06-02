//
//  User.h
//  iBilancio
//
//  Created by Fabio Sassu on 21/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * isAdmin;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSManagedObject *doesA;

@end
