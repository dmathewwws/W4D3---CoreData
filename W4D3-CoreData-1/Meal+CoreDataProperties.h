//
//  Meal+CoreDataProperties.h
//  W4D3-CoreData-1
//
//  Created by Admin on 2016-09-28.
//  Copyright © 2016 ToyBox Media. All rights reserved.
//

#import "Meal+CoreDataClass.h"
#import "User+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface Meal (CoreDataProperties)

+ (NSFetchRequest<Meal *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSNumber *calories;
@property (nullable, nonatomic, retain) User *newRelationship;

@end

NS_ASSUME_NONNULL_END
