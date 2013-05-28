//
//  NewUserViewController.m
//  iBilancio
//
//  Created by Fabio Sassu on 21/05/13.
//  Copyright (c) 2013 Fabio Sassu. All rights reserved.
//

#import "NewUserViewController.h"
#import "NewUser.h"
#import "AppDelegate.h"
#import "User.h"

@interface NewUserViewController ()

@end

@implementation NewUserViewController

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

- (IBAction)addUser:(id)sender
{
    NSString *tmp = [NSString stringWithFormat:@"%@",self.userNamez.text];
    NewUser *newUser = [[NewUser alloc]initWithUserName:tmp];
    if (self.admin.on)
    {
        newUser.isAdmin = [NSNumber numberWithInt:1];
    }
    else
    {
        newUser.isAdmin = [NSNumber numberWithInt:0];
    }
    
    AppDelegate *app  = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *context = [app managedObjectContext];
    
    User *newUser2 = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newUser2 setValue:newUser.userName forKey:@"name"];
    [newUser2 setValue:newUser.isAdmin forKey:@"isAdmin"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    [self.navigationController popViewControllerAnimated:YES];
    [newUser release];
    [tmp release];
}

- (IBAction)cancel:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
