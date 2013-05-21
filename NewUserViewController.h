//
//  NewUserViewController.h
//  iBilancio
//
//  Created by Fabio Sassu on 21/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewUserViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *userNamez;
@property (nonatomic, strong) IBOutlet UISwitch *admin;

@end
