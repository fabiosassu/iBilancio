//
//  NewUserViewController.m
//  iBilancio
//
//  Created by Fabio Sassu on 21/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import "NewUserViewController.h"
#import "NewUser.h"

@interface NewUserViewController ()

@end

@implementation NewUserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"New User";
    
    [self.navigationItem setHidesBackButton:TRUE];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    [self.navigationItem setLeftBarButtonItem:leftBarButton];
    [leftBarButton release];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(addUser:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    
    [self.userNamez becomeFirstResponder];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)addUser:(id)sender{
    NSString *tmp = [NSString stringWithFormat:@"%@",self.userNamez.text];
    NewUser *newUser = [[NewUser alloc]initWithUserName:tmp];
    if (self.admin.on){
        newUser.isAdmin = YES;
    } else {
        newUser.isAdmin = NO;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"isThereAnyUser" object:newUser];
    [self.navigationController popViewControllerAnimated:YES];
    [newUser release];
    [tmp release];
}

- (IBAction)cancel:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
