//
//  User+CoreDataProperties.h
//  W4D3-CoreData-1
//
//  Created by Admin on 2016-09-28.
//  Copyright © 2016 ToyBox Media. All rights reserved.
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSSet<Meal *> *meals;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addMealsObject:(Meal *)value;
- (void)removeMealsObject:(Meal *)value;
- (void)addMeals:(NSSet<Meal *> *)values;
- (void)removeMeals:(NSSet<Meal *> *)values;

@end

NS_ASSUME_NONNULL_END
