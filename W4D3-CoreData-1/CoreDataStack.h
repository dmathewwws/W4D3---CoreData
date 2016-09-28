//
//  CoreDataStack.h
//  W4D3-CoreData-1
//
//  Created by Admin on 2016-09-28.
//  Copyright © 2016 ToyBox Media. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface CoreDataStack : NSObject

@property (nonatomic) NSManagedObjectContext* context;

+ (id)sharedManager;

@end
