//
//  ViewController.h
//  CodeNameGenerator
//
//  Created by Barry Rowe on 4/26/13.
//  Copyright (c) 2013 ElephanTango. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch * useColors;
@property (weak, nonatomic) IBOutlet UISwitch * useAnimals;
@property (weak, nonatomic) IBOutlet UISwitch * useConcepts;
@property (weak, nonatomic) IBOutlet UISwitch * useVerbs;

@property (weak, nonatomic) IBOutlet UISwitch *useColors2;
@property (weak, nonatomic) IBOutlet UISwitch *useAnimals2;
@property (weak, nonatomic) IBOutlet UISwitch *useConcepts2;
@property (weak, nonatomic) IBOutlet UISwitch *useVerbs2;


@property (weak, nonatomic) IBOutlet UILabel * codeNameResult;


- (IBAction) generateCodeName:(id)sender;
@end
