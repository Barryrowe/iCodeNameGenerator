//
//  ViewController.m
//  CodeNameGenerator
//
//  Created by Barry Rowe on 4/26/13.
//  Copyright (c) 2013 ElephanTango. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "CodeNameFactory.h"
#import "GHRepository.h"

@interface ViewController (){
    CodeNameInfo *lastCodeName;
    NSArray *ghRepos;
}
@end

@implementation ViewController

static NSString *_defaultSummaryText = @"--Enter a description for your App--";
static CATransition *labelAnimation;

-(IBAction) generateCodeName:(id)sender {
    
        lastCodeName = [[CodeNameFactory sharedFactory] generateCodeNameUsingColors:[[self useColors] isOn]
                                                                       UsingAnimals:[[self useAnimals] isOn]
                                                                      UsingConcepts:[[self useConcepts] isOn]
                                                                         UsingVerbs:[[self useVerbs] isOn]
                                                                       UsingColors2:[[self useColors2] isOn]
                                                                      UsingAnimals2:[[self useAnimals2] isOn]
                                                                     UsingConcepts2:[[self useConcepts2] isOn]
                                                                        UsingVerbs2:[[self useVerbs2] isOn]];

    [self verifyAvailabilityOfName:lastCodeName];
    //[self setResultLabelAnimation:labelAnimation];
    NSString *displayText = [NSString stringWithFormat:@"%@ (%@)",
                             [lastCodeName displayName],
                             @"Checking Github Availability" ];
    [[self codeNameResult] setText:displayText];
    [[self codeNameResult] setTextColor:[UIColor blueColor]];

    [[self saveButton] setEnabled:YES];
}

-(IBAction) saveCodeName:(id)sender{
    lastCodeName.summary = self.codeNameDesc.text;
    [[CodeNameFactory sharedFactory] addCodeName:lastCodeName];
    [sender setEnabled:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Setup our Animation for the Result Label
    labelAnimation = [CATransition animation];
    labelAnimation.duration = 1.0;
    labelAnimation.type = kCATransitionFade;
    labelAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    //Style up our switch labels
    [[self colorsLabel] setTextAlignment:NSTextAlignmentCenter];
    [[self animalsLabel] setTextAlignment:NSTextAlignmentCenter];
    [[self conceptsLabel] setTextAlignment:NSTextAlignmentCenter];
    [[self verbsLabel] setTextAlignment:NSTextAlignmentCenter];
    
    //Style our Result Label
    [[self codeNameResult] setTextAlignment:NSTextAlignmentCenter];
    [[self codeNameResult] setTextColor:[UIColor blueColor]];
  
    
    //Setup our Summary field
    self.codeNameDesc.layer.cornerRadius = 5;
    [[[self codeNameDesc] layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[[self codeNameDesc] layer] setBorderWidth:2.3];
    [[self codeNameDesc] setText:_defaultSummaryText];
    _codeNameDesc.delegate = self;
    
    //Setup View
    [[self view]setBackgroundColor:[UIColor lightGrayColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) verifyAvailabilityOfName:(CodeNameInfo *)info{
    // Use the GitHub API!
    NSString *searchTerm = [NSString stringWithFormat:@"%@-%@", info.firstWord, info.secondWord];
    NSString *ghEventsAPIURL = [NSString stringWithFormat:@"https://api.github.com/legacy/repos/search/%@", searchTerm];
    
    NSURL *url = [[NSURL alloc] initWithString:ghEventsAPIURL];
    NSMutableURLRequest *newReq = [[NSMutableURLRequest alloc] initWithURL:url];
    [newReq setValue:@"NO-CACHE" forHTTPHeaderField:@"Cache-control"];
    
    void (^handler)(NSURLResponse *, NSData *, NSError *) =
    ^(NSURLResponse *urlResponse, NSData *responseData, NSError *error){
        if([urlResponse isKindOfClass:[NSHTTPURLResponse class]]){
            NSDictionary *headers = [(NSHTTPURLResponse *)urlResponse allHeaderFields];
            NSString *rateLimit = headers[@"X-RateLimit-Limit"];
            NSString *callsLeft = headers[@"X-RateLimit-Remaining"];
            NSLog(@"%@ of %@ calls remaining", callsLeft, rateLimit);
        }
        ghRepos = [GHRepository reposFromJson:responseData];
        
        NSString *resultText = @"Unavailable on Github :(";
        UIColor *resultColor = [UIColor redColor];
        
        if([ghRepos count] > 0){
            NSLog(@"Repository Exists with Name: %@.", searchTerm);
        }else{
            NSLog(@"Repository name %@ is available!", searchTerm);
            resultText = @"Available on GitHub!";
            resultColor = [UIColor greenColor];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setResultLabelAnimation:labelAnimation];
            [self.codeNameResult setText:[NSString stringWithFormat:@"%@ \n(%@)",
                                          [lastCodeName displayName],
                                          resultText]];
            [self.codeNameResult setTextColor:resultColor];
            
        });
    
    };
    
    [NSURLConnection sendAsynchronousRequest:newReq
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:handler];
}


//
//UITextFieldDelegate Protocol Implementation
///
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan Called");
    [self.codeNameDesc resignFirstResponder];
}

- (void) textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"Begin Editing FIred");
    if([[textView text] isEqualToString:_defaultSummaryText]){
        [textView setText:@""];
    }
}

- (void) textViewDidEndEditing:(UITextView *)textView{
    if([[textView text] isEqualToString:@""]){
         [textView setText:_defaultSummaryText];
    }
}
//---

//
//Private utility Methods
///
-(void) setResultLabelAnimation:(CATransition *)transition{
    [self.codeNameResult.layer addAnimation:transition
                                     forKey:@"changeTextTransition"];
}
//---

@end
