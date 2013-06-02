//
//  TValueViewController.h
//  iBilancio
//
//  Created by Fabio Sassu on 21/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TValueViewController : UIViewController

@property (nonatomic,strong) IBOutlet UILabel *value;
@property (nonatomic, strong) IBOutlet UIButton *signButton;
@property (nonatomic, strong) IBOutlet UIImageView *valueLabel;
@property (nonatomic) double accumulator;

- (IBAction)numberKeyPressed:(id)sender;

@end
