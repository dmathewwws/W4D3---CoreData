//
//  Meal+CoreDataProperties.m
//  W4D3-CoreData-1
//
//  Created by Admin on 2016-09-28.
//  Copyright © 2016 ToyBox Media. All rights reserved.
//

#import "Meal+CoreDataProperties.h"

@implementation Meal (CoreDataProperties)

+ (NSFetchRequest<Meal *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Meal"];
}

@dynamic name;
@dynamic calories;
@dynamic newRelationship;

@end
