//
//  CoreDataStack.m
//  W4D3-CoreData-1
//
//  Created by Admin on 2016-09-28.
//  Copyright © 2016 ToyBox Media. All rights reserved.
//

#import "CoreDataStack.h"

@implementation CoreDataStack

+ (id)sharedManager {
    static CoreDataStack *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSURL *momdURL = [[NSBundle mainBundle] URLForResource:@"FoodTracker" withExtension:@"momd"];
        NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:momdURL];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
        
        NSArray *docDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [docDirs firstObject];
        NSString *dbPath = [documentsPath stringByAppendingPathComponent:@"meals.db"];
        NSURL *dbUrl = [NSURL fileURLWithPath:dbPath];
        
        NSError *pscError = nil;
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:dbUrl options:nil error:&pscError]) {
            NSLog(@"error creating psc %@", pscError);
        }
        
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_context setPersistentStoreCoordinator:psc];
        
    }
    return self;
}


@end
