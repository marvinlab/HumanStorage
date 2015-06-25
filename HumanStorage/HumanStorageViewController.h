//
//  HumanStorageViewController.h
//  HumanStorage
//
//  Created by Marvin Labrador on 6/4/15.
//  Copyright (c) 2015 Marvin Labrador. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HumanStorageViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UITextField *fNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *lNameTextField;

- (IBAction)storeHumanButtonAction:(id)sender;
- (IBAction)searchHumanButtonAction:(id)sender;
- (IBAction)setHumanFreeButtonAction:(id)sender;
- (IBAction)displayListOfHumans:(id)sender;

@end
