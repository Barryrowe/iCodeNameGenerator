//
//  CodeNameFactory.m
//  CodeNameGenerator
//
//  Created by Barry Rowe on 4/26/13.
//  Copyright (c) 2013 ElephanTango. All rights reserved.
//

#import "CodeNameFactory.h"

@interface CodeNameFactory(){
    NSMutableArray *_colors;
    NSMutableArray *_animals;
    NSMutableArray *_concepts;
    NSMutableArray *_verbs;
    
    NSMutableArray *_codeNames;
}
@end

@implementation CodeNameFactory

@synthesize colors = _colors;
@synthesize animals = _animals;
@synthesize concepts = _concepts;
@synthesize verbs = _verbs;


+ (CodeNameFactory *) sharedFactory{
    static CodeNameFactory * sharedFactory = nil;
    if(!sharedFactory){
        sharedFactory = [[super allocWithZone:nil] init];
    }
    
    return sharedFactory;
}

-(id)init{
    self = [super init];
    if(self){
        _colors     = [[NSMutableArray alloc] initWithObjects:@"Red", @"Blue", @"Purple", @"Green", @"Oragne", @"Yellow", @"Aquamarine", @"Fuschia", nil];
        
        _animals    = [[NSMutableArray alloc] initWithObjects:@"Elephant",
                    @"Zebra", @"Lion", @"Gorilla", @"Armadillo", @"Whale", @"Sloth", @"Butterfly", nil];
        _concepts   = [[NSMutableArray alloc] initWithObjects:@"Motion", @"Gravity", @"Synergy", @"Crisis", @"War", nil];
        _verbs      = [[NSMutableArray alloc] initWithObjects:@"Slash", @"Spark", @"Crack", @"Reward", @"Defend", @"Parade", nil];
        
        _codeNames  = [[NSMutableArray alloc] init];
    }
    
    return self;
}


- (NSString *) generateCodeNameUsingColors:(BOOL)useColors UsingAnimals:(BOOL)useAnimals UsingConcepts:(BOOL)useConcepts UsingVerbs:(BOOL)useVerbs UsingColors2:(BOOL)useColors2 UsingAnimals2:(BOOL)useAnimals2 UsingConcepts2:(BOOL)useConcepts2 UsingVerbs2:(BOOL)useVerbs2{
    
    NSString * firstWord = [self getRandomStringUsingColors:useColors UsingAnimals:useAnimals UsingConcepts:useConcepts UsingVerbs:useVerbs AndNotSameAs:@"--"];
    
    NSString * secondWord = [self getRandomStringUsingColors:useColors2 UsingAnimals:useAnimals2 UsingConcepts:useConcepts2 UsingVerbs:useVerbs2 AndNotSameAs:firstWord];
    
    NSString * codeName = [NSString stringWithFormat:@"%@ %@", firstWord, secondWord];
    [[self codeNames] addObject:codeName];
    
    return codeName;
    
}
- (NSString *) generateCodeNameUsingColors:(BOOL)useColors UsingAnimals:(BOOL)useAnimals UsingConcepts:(BOOL)useConcepts UsingVerbs:(BOOL)useVerbs{
    
    return [self generateCodeNameUsingColors:useColors
                                UsingAnimals:useAnimals
                               UsingConcepts:useConcepts
                                  UsingVerbs:useVerbs
                                UsingColors2:useColors
                               UsingAnimals2:useAnimals
                              UsingConcepts2:useConcepts
                                 UsingVerbs2:useVerbs];
}

- (NSString *) getRandomStringUsingColors:(BOOL)useColors UsingAnimals:(BOOL)useAnimals UsingConcepts:(BOOL)useConcepts UsingVerbs:(BOOL)useVerbs AndNotSameAs:(NSString *)dupe{
  
    int maxIndex = 0;
    
    NSMutableArray * searchArray = [[NSMutableArray alloc] init];
    
    if(useColors){
        maxIndex += [[self colors] count] - 1;
        [searchArray addObjectsFromArray:[self colors]];
    }
    
    if(useAnimals){
        maxIndex += [[self animals] count] -1;
        [searchArray addObjectsFromArray:[self animals]];
    }
    
    if(useConcepts){
        maxIndex += [[self concepts] count] -1;
        [searchArray addObjectsFromArray:[self concepts]];
    }
    
    if(useVerbs){
        maxIndex += [[self verbs] count] -1;
        [searchArray addObjectsFromArray:[self verbs]];
    }

    
    
    if(maxIndex < 1){
        return @"--";
    }
    int targetIndex = rand() % maxIndex;
    NSString * randString = [searchArray objectAtIndex:targetIndex];
    while([randString isEqualToString:dupe]){
        targetIndex = (targetIndex + 1) % maxIndex;
        randString = [searchArray objectAtIndex:targetIndex];
    }
    
    return randString;
    
}
@end
