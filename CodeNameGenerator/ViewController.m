//
//  ViewController.m
//  CodeNameGenerator
//
//  Created by Barry Rowe on 4/26/13.
//  Copyright (c) 2013 ElephanTango. All rights reserved.
//

#import "ViewController.h"
#import "CodeNameFactory.h"
#import "GHRepository.h"

@interface ViewController (){
    CodeNameInfo *lastCodeName;
    NSArray *ghRepos;
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

    [self verifyAvailabilityOfName:lastCodeName];
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
        if([ghRepos count] > 0){
            NSLog(@"Repository Exists with Name: %@.", searchTerm);
        }else{
            NSLog(@"Repository name %@ is available!", searchTerm);
        }
        
    };
    
    [NSURLConnection sendAsynchronousRequest:newReq
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:handler];
}

@end
