//
//  CodeNameFactory.m
//  CodeNameGenerator
//
//  Created by Barry Rowe on 4/26/13.
//  Copyright (c) 2013 ElephanTango. All rights reserved.
//

#import "CodeNameFactory.h"
#import "CodeNameInfo.h"
#import <CoreData/CoreData.h>

@interface CodeNameFactory(){
    NSMutableArray *_colors;
    NSMutableArray *_animals;
    NSMutableArray *_concepts;
    NSMutableArray *_verbs;
    
    NSMutableArray *codeNames;
    NSManagedObjectContext * _context;
    NSManagedObjectModel * _model;
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
        
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
        NSString *path = [self dataArchivePath];
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        NSError *error = nil;
        
        if(![psc addPersistentStoreWithType:NSSQLiteStoreType
                              configuration:nil
                                        URL:storeURL
                                    options:nil
                                      error:&error]){
            [NSException raise:@"Open Failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        _context = [[NSManagedObjectContext alloc] init];
        [_context setPersistentStoreCoordinator:psc];
        [_context setUndoManager:nil];
        
        _colors     = [[NSMutableArray alloc] initWithObjects:@"Red", @"Blue", @"Purple", @"Green", @"Oragne", @"Yellow", @"Aquamarine", @"Fuschia", nil];
        
        _animals    = [[NSMutableArray alloc] initWithObjects:@"Elephant",
                    @"Zebra", @"Lion", @"Gorilla", @"Armadillo", @"Whale", @"Sloth", @"Butterfly", nil];
        _concepts   = [[NSMutableArray alloc] initWithObjects:@"Motion", @"Gravity", @"Synergy", @"Crisis", @"War", nil];
        _verbs      = [[NSMutableArray alloc] initWithObjects:@"Slash", @"Spark", @"Crack", @"Reward", @"Defend", @"Parade", nil];
        
        [self loadAllCodeNames];
        for (CodeName *cn in codeNames) {
            NSLog(@"CodeName: %@", cn);
        }
    }
    
    return self;
}

- (CodeNameInfo *) generateCodeNameUsingColors:(BOOL)useColors UsingAnimals:(BOOL)useAnimals UsingConcepts:(BOOL)useConcepts UsingVerbs:(BOOL)useVerbs UsingColors2:(BOOL)useColors2 UsingAnimals2:(BOOL)useAnimals2 UsingConcepts2:(BOOL)useConcepts2 UsingVerbs2:(BOOL)useVerbs2{
    
    NSString * firstWord = [self getRandomStringUsingColors:useColors
                                               UsingAnimals:useAnimals
                                              UsingConcepts:useConcepts
                                                 UsingVerbs:useVerbs
                                               AndNotSameAs:@"--"];
    
    NSString * secondWord = [self getRandomStringUsingColors:useColors2
                                                UsingAnimals:useAnimals2
                                               UsingConcepts:useConcepts2
                                                  UsingVerbs:useVerbs2
                                                AndNotSameAs:firstWord];
    
    CodeNameInfo * codeName = [[CodeNameInfo alloc] initWithFirstWord:firstWord
                                                           SecondWord:secondWord
                                                              Summary:@""
                                                           AndRepoUrl:@""];
    
    //[codeNames addObject:codeName];
    
    return codeName;
}

-(NSString *)dataArchivePath{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"codename.data"];
}

//
//CodeName Manipulation Methods
///
-(NSArray *) allCodeNames{
    return codeNames;
}

-(void) removeCodeName:(CodeName *)codeName{
    [_context deleteObject:codeName];
    [codeNames removeObjectIdenticalTo:codeName];
    [self saveChanges];
}

-(CodeName *) addCodeName:(CodeNameInfo *)codeName{
    CodeName * newCodeName = [NSEntityDescription insertNewObjectForEntityForName:@"CodeName"
                                                           inManagedObjectContext:_context];
    NSString *name = [NSString stringWithFormat:@"%@ %@", [codeName firstWord], [codeName secondWord]];
    [newCodeName setName:name];
    [newCodeName setFirstWord:[codeName firstWord]];
    [newCodeName setSecondWord:[codeName secondWord]];
    [newCodeName setRepoUrl:[codeName repoUrl]];
    [newCodeName setSummary:[codeName summary]];
    
    [self saveChanges];
    [codeNames addObject:newCodeName];
    return newCodeName;
}

- (BOOL) saveChanges{
    NSError *err = nil;
    BOOL successful = [_context save:&err];
    
    if(!successful){
        NSLog(@"Error saving: %@", [err localizedDescription]);
    }
    return successful;
}

- (void) loadAllCodeNames{
    if(!codeNames){
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *e = [[_model entitiesByName] objectForKey:@"CodeName"];
        [request setEntity:e];
        
        NSError *error;
        NSArray *result = [_context executeFetchRequest:request error:&error];
        if(!result){
            [NSException raise:@"Fetch failed"
                        format:@"Reason:%@", [error localizedDescription]];
        }
        
        codeNames = [[NSMutableArray alloc] initWithArray:result];
    }
}
//---

//
//Private Method(s)
///
- (NSString *) getRandomStringUsingColors:(BOOL)useColors
                             UsingAnimals:(BOOL)useAnimals
                            UsingConcepts:(BOOL)useConcepts
                               UsingVerbs:(BOOL)useVerbs
                             AndNotSameAs:(NSString *)dupe{
  
    NSLog(@"UseColors: %i\nUseAnimals: %i\nUseConcepts: %i\nUseVerbs: %i\nDupe: %@", useColors, useAnimals, useConcepts, useVerbs, dupe);
    int maxIndex = 0;
    
    NSMutableArray * searchArray = [[NSMutableArray alloc] init];
    
    if(useColors){
        [searchArray addObjectsFromArray:[self colors]];
    }
    
    if(useAnimals){
        [searchArray addObjectsFromArray:[self animals]];
    }
    
    if(useConcepts){
        [searchArray addObjectsFromArray:[self concepts]];
    }
    
    if(useVerbs){
        [searchArray addObjectsFromArray:[self verbs]];
    }
    
    maxIndex = [searchArray count] -1;
    NSLog(@"Max Index: %d", maxIndex);
    
    if(maxIndex < 1){
        return @"--";
    }
    
    int targetIndex = arc4random_uniform(maxIndex); //rand() % maxIndex;
    NSString * randString = [searchArray objectAtIndex:targetIndex];
    //No need to do a while loop, if we're the same, the Next value can't be
    //  the same. So we just grab the next value. It's cleaner logic
    if([randString isEqualToString:dupe]){
        targetIndex = (targetIndex + 1) % maxIndex;
        randString = [searchArray objectAtIndex:targetIndex];
    }
    
    return randString;
    
}
@end
