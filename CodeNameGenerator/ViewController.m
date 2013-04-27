//
//  ViewController.m
//  CodeNameGenerator
//
//  Created by Barry Rowe on 4/26/13.
//  Copyright (c) 2013 ElephanTango. All rights reserved.
//

#import "ViewController.h"
#import "CodeNameFactory.h"

@interface ViewController ()

@end

@implementation ViewController


-(IBAction) generateCodeName:(id)sender {
    
        NSString * codeName = [[CodeNameFactory sharedFactory] generateCodeNameUsingColors:[[self useColors] isOn]
                                                                              UsingAnimals:[[self useAnimals] isOn]
                                                                             UsingConcepts:[[self useConcepts] isOn]
                                                                                UsingVerbs:[[self useVerbs] isOn]];
    
    [[self codeNameResult] setText:codeName];    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
