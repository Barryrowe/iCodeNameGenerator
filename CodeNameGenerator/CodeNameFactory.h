//
//  CodeNameFactory.h
//  CodeNameGenerator
//
//  Created by Barry Rowe on 4/26/13.
//  Copyright (c) 2013 ElephanTango. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CodeNameInfo.h"
#import "CodeName.h"

@interface CodeNameFactory : NSObject
{

}

+ (CodeNameFactory *) sharedFactory;

@property (nonatomic, strong, readonly) NSArray * colors;
@property (nonatomic, strong, readonly) NSArray * animals;
@property (nonatomic, strong, readonly) NSArray * concepts;
@property (nonatomic, strong, readonly) NSArray * verbs;


- (CodeNameInfo *) generateCodeNameUsingColors:(BOOL)useColors UsingAnimals:(BOOL)useAnimals UsingConcepts:(BOOL)useConcepts UsingVerbs:(BOOL)useVerbs UsingColors2:(BOOL)useColors2 UsingAnimals2:(BOOL)useAnimals2 UsingConcepts2:(BOOL)useConcepts2 UsingVerbs2:(BOOL)useVerbs2;

- (NSArray *) allCodeNames;
- (void) removeCodeName:(CodeName *)codeName;
- (CodeName *) addCodeName:(CodeNameInfo *)codeName;
- (BOOL) saveChanges;

//Doesn't Belong Here
- (NSString *)dataArchivePath;

@end
