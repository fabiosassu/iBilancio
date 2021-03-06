//
//  TValueViewController.m
//  iBilancio
//
//  Created by Fabio Sassu on 21/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import "TValueViewController.h"
#import "NewTransactionViewController.h"

@interface TValueViewController ()

@end

@implementation TValueViewController
bool positivo;
- (void)viewDidLoad
{
    [super viewDidLoad];
    positivo = YES;
    [self.navigationItem setHidesBackButton:TRUE];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    [self.navigationItem setLeftBarButtonItem:leftBarButton];
    [leftBarButton release];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveValue:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    
    self.view.backgroundColor = [[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"otherBackground.png"]]autorelease];
}

- (IBAction)numberKeyPressed:(id)sender
{
    UIButton *b=(UIButton*) sender;
    double insertedNumber = b.tag*0.01;
    //double max = trovare limite max double
    self.accumulator = self.accumulator*10+insertedNumber;
    self.value.text = [NSString stringWithFormat:@"%.2f",self.accumulator];
}

- (IBAction)signChangeKeyPressed:(id)sender
{
    //self.accumulator *= -1;
    
    self.value.text=[NSString stringWithFormat:@"%.2f",self.accumulator];
    
    positivo = !positivo;
    if (positivo){
        UIImage *button = [UIImage imageNamed:@"plusButton"];
        UIImage *label = [UIImage imageNamed:@"plusLabel"];
        [self.signButton setImage:button forState:0];
        [self.valueLabel setImage:label];
    }
    else{
        UIImage *button = [UIImage imageNamed:@"minusButton"];
        UIImage *label = [UIImage imageNamed:@"minusLabel"];
        [self.signButton setImage:button forState:0];
        [self.valueLabel setImage:label];
    }
    
}

- (IBAction)backSpaceKeyPressed:(id)sender
{
    self.accumulator *= 10;
    self.accumulator = (int)self.accumulator;
    self.accumulator /= 100;
    
    self.value.text = [NSString stringWithFormat:@"%.2f",self.accumulator];
}

- (IBAction)doubleZeroKeyPressed:(id)sender
{
    self.accumulator = self.accumulator*100;
    self.value.text = [NSString stringWithFormat:@"%.2f",self.accumulator];
}

- (IBAction)cancel:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveValue:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedValue" object:[NSNumber numberWithDouble:self.accumulator]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"positivo" object:[NSNumber numberWithBool:positivo]];
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
