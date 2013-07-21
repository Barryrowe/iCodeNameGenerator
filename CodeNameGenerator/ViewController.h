//
//  ViewController.h
//  CodeNameGenerator
//
//  Created by Barry Rowe on 4/26/13.
//  Copyright (c) 2013 ElephanTango. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UISwitch * useColors;
@property (weak, nonatomic) IBOutlet UISwitch * useAnimals;
@property (weak, nonatomic) IBOutlet UISwitch * useConcepts;
@property (weak, nonatomic) IBOutlet UISwitch * useVerbs;

@property (weak, nonatomic) IBOutlet UISwitch *useColors2;
@property (weak, nonatomic) IBOutlet UISwitch *useAnimals2;
@property (weak, nonatomic) IBOutlet UISwitch *useConcepts2;
@property (weak, nonatomic) IBOutlet UISwitch *useVerbs2;

@property (weak, nonatomic) IBOutlet UILabel *colorsLabel;
@property (weak, nonatomic) IBOutlet UILabel *animalsLabel;
@property (weak, nonatomic) IBOutlet UILabel *conceptsLabel;
@property (weak, nonatomic) IBOutlet UILabel *verbsLabel;


@property (weak, nonatomic) IBOutlet UILabel * codeNameResult;
@property (weak, nonatomic) IBOutlet UITextView *codeNameDesc;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

- (IBAction) generateCodeName:(id)sender;
- (IBAction) saveCodeName:(id)sender;
@end
