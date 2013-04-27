//
//  CodeNameFactory.h
//  CodeNameGenerator
//
//  Created by Barry Rowe on 4/26/13.
//  Copyright (c) 2013 ElephanTango. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodeNameFactory : NSObject
{

}

+ (CodeNameFactory *) sharedFactory;

@property (nonatomic, strong, readonly) NSArray * colors;
@property (nonatomic, strong, readonly) NSArray * animals;
@property (nonatomic, strong, readonly) NSArray * concepts;
@property (nonatomic, strong, readonly) NSArray * verbs;

@property (nonatomic, strong, readonly) NSMutableArray * codeNames;

- (NSString *) generateCodeNameUsingColors:(BOOL)useColors UsingAnimals:(BOOL)useAnimals UsingConcepts:(BOOL)useConcepts UsingVerbs:(BOOL)useVerbs;

@end
