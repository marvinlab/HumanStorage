//
//  HumanStorageViewController.m
//  HumanStorage
//
//  Created by Marvin Labrador on 6/4/15.
//  Copyright (c) 2015 Marvin Labrador. All rights reserved.
//

#import "HumanStorageViewController.h"
#import "AppDelegate.h"


@interface HumanStorageViewController ()

@property (retain, nonatomic) NSManagedObjectContext *context;


@end

@implementation HumanStorageViewController


- (void)dealloc
{
    self.lNameTextField = nil;
    self.fNameTextField = nil;
    self.context = nil;
    
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegInstance = [[UIApplication sharedApplication]delegate];
    self.context = [appDelegInstance managedObjectContext];
    
    [self.fNameTextField setDelegate:self];
    [self.lNameTextField setDelegate:self];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    return [textField resignFirstResponder];
    
}

- (IBAction)storeHumanButtonAction:(id)sender{
    
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"PersonModel" inManagedObjectContext:self.context];
    NSManagedObject *newHuman = [[NSManagedObject alloc]initWithEntity:desc insertIntoManagedObjectContext:self.context];
    
    [newHuman setValue:self.fNameTextField.text forKey:@"firstName"];
    [newHuman setValue:self.lNameTextField.text forKey:@"lastName"];
    
    NSError *error;
    
    NSString *title;
    NSString *message;
    
    if ([self.lNameTextField.text isEqualToString:@""] || [self.fNameTextField.text isEqualToString:@""]) {
        title = @"OOps!";
        message = @"You've entered Invalid / Empty / Incomplete Values. Please Enter a human First name and A human last name";
    } else {
        
        title = @"Success";
        message = [NSString stringWithFormat:@"the human with a name \"%@ %@\" has been successfully locked in its storage cell!",self.fNameTextField.text, self.lNameTextField.text];
        [self.context save:&error];
    }
    
    self.fNameTextField.text = @"";
    self.lNameTextField.text = @"";
    
    UIAlertView *saveAlert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [saveAlert show];
    [saveAlert release];

}


- (IBAction)searchHumanButtonAction:(id)sender{
    
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"PersonModel" inManagedObjectContext:self.context];

    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:desc];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstName like %@ and lastName like %@",self.fNameTextField.text,self.lNameTextField.text];
    [request setPredicate:predicate];
    NSError *error;
    NSString *message;
    NSArray *searchResult = [self.context executeFetchRequest:request error:&error];
    message = @"This human is not found anywhere!";
    
    if (searchResult.count != 0) {
        message = [NSString stringWithFormat:@"%ld human with name \"%@ %@\" found!",searchResult.count,self.fNameTextField.text,self.lNameTextField.text];
    }
    
    self.fNameTextField.text = @"";
    self.lNameTextField.text = @"";
    UIAlertView *searchAlert = [[UIAlertView alloc]initWithTitle:@"Search" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [searchAlert show];
    [searchAlert release];
}


- (IBAction)setHumanFreeButtonAction:(id)sender{
    AppDelegate *appDeleg = [[[AppDelegate alloc]init]autorelease];
    NSManagedObjectContext *context = [appDeleg managedObjectContext];
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"PersonModel" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:desc];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstName like %@ and lastName like %@",self.fNameTextField.text,self.lNameTextField.text];
    [request setPredicate:predicate];
    NSError *error;
    NSString *message;
    NSArray *searchResult = [context executeFetchRequest:request error:&error];
    message = @"This human is not found anywhere!\nMake sure you entered a correct/valid first and last name";
    
    if (searchResult.count != 0) {
    message = @"humans with name/s ";
        for (NSManagedObject *obj in searchResult)
        {
            message = [message stringByAppendingString:[NSString stringWithFormat:@"\"%@ %@\", ",[obj valueForKey:@"firstName"],[obj valueForKey:@"lastName"]]];
            [context deleteObject:obj];
        }
        message = [message stringByAppendingString:@" attained Freedom!"];
        [context save:&error];
    }
    
    self.fNameTextField.text = @"";
    self.lNameTextField.text = @"";
    UIAlertView *deleteAlert = [[UIAlertView alloc]initWithTitle:@"Free" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [deleteAlert show];
    [deleteAlert release];
}


- (IBAction)displayListOfHumans:(id)sender
{
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"PersonModel" inManagedObjectContext:self.context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:desc];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstName like %@ and lastName like %@",@"*",@"*"];
    [request setPredicate:predicate];
    NSError *error;
    NSString *message;
    NSArray *searchResult = [self.context executeFetchRequest:request error:&error];
    message = @"No Humans found";
    
    if (searchResult.count != 0) {
        message = @"here are your humans:\n\n";
        for (NSManagedObject *obj in searchResult) {
            message = [message stringByAppendingString:[NSString stringWithFormat:@" -- %@ %@ \n",[obj valueForKey:@"firstName"],[obj valueForKey:@"lastName"]]];
        }
    }
    self.fNameTextField.text = @"";
    self.lNameTextField.text = @"";
    UIAlertView *searchAlert = [[UIAlertView alloc]initWithTitle:@"Search" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [searchAlert show];
    [searchAlert release];
}

@end
