//
//  ViewController.m
//  CodeNameGenerator
//
//  Created by Barry Rowe on 4/26/13.
//  Copyright (c) 2013 ElephanTango. All rights reserved.
//

#import "ViewController.h"
#import "CodeNameFactory.h"

@interface ViewController (){
    CodeNameInfo *lastCodeName;
}
@end

@implementation ViewController


-(IBAction) generateCodeName:(id)sender {
    
        lastCodeName = [[CodeNameFactory sharedFactory] generateCodeNameUsingColors:[[self useColors] isOn]
                                                                              UsingAnimals:[[self useAnimals] isOn]
                                                                             UsingConcepts:[[self useConcepts] isOn]
                                                                                UsingVerbs:[[self useVerbs] isOn]
                                                                              UsingColors2:[[self useColors2] isOn]
                                                                             UsingAnimals2:[[self useAnimals2] isOn]
                                                                            UsingConcepts2:[[self useConcepts2] isOn]
                                                                               UsingVerbs2:[[self useVerbs2] isOn]];
    
    [[self codeNameResult] setText:[lastCodeName displayName]];
    [[self saveButton] setEnabled:YES];
}

-(IBAction) saveCodeName:(id)sender{
    [[CodeNameFactory sharedFactory] addCodeName:lastCodeName];
    [sender setEnabled:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[self colorsLabel] setTextAlignment:NSTextAlignmentCenter];
    [[self animalsLabel] setTextAlignment:NSTextAlignmentCenter];
    [[self conceptsLabel] setTextAlignment:NSTextAlignmentCenter];
    [[self verbsLabel] setTextAlignment:NSTextAlignmentCenter];
    [[self codeNameResult] setTextAlignment:NSTextAlignmentCenter];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
