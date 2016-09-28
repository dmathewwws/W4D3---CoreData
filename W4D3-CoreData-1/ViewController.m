//
//  ViewController.m
//  W4D3-CoreData-1
//
//  Created by Admin on 2016-09-28.
//  Copyright © 2016 ToyBox Media. All rights reserved.
//

#import "ViewController.h"
#import "Meal+CoreDataProperties.h"
#import "CoreDataStack.h"

@interface ViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) CoreDataStack *stack;
@property (nonatomic) NSFetchedResultsController *frc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    self.stack = [CoreDataStack sharedManager];
    
    NSFetchRequest *mealFetchRequest =  [Meal fetchRequest];
    mealFetchRequest.fetchLimit = 100;
    

    NSSortDescriptor *sortDescription = [NSSortDescriptor sortDescriptorWithKey:@"calories" ascending:YES];
    
    mealFetchRequest.sortDescriptors = @[sortDescription];
    
    mealFetchRequest.predicate = [NSPredicate predicateWithFormat:@"name == %@", @"Apple"];
    
    
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest:mealFetchRequest managedObjectContext:self.stack.context sectionNameKeyPath:nil cacheName:nil];
    self.frc.delegate = self;
    
    NSError *fetchError = nil;
    [self.frc performFetch:&fetchError];
    
}

- (IBAction)addButtonPressed:(UIBarButtonItem *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Enter New Meal" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    
    __block UITextField *nameTextField;
    __block UITextField *caloriesTextField;
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        nameTextField = textField;
        
        
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        caloriesTextField = textField;
        
        
        
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        NSString *name = nameTextField.text;
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        NSNumber *calories = [formatter numberFromString:caloriesTextField.text];
        
        Meal *meal = [NSEntityDescription insertNewObjectForEntityForName:@"Meal" inManagedObjectContext:self.stack.context];
        
        meal.name = name;
        meal.calories = calories;
        
        NSError *contextError = nil;
        [self.stack.context save:&contextError];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    
    [self presentViewController:alertController animated:NO completion:nil];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[self.frc sections] count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.frc.sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Meal *meal = [self.frc objectAtIndexPath:indexPath];
    
    cell.textLabel.text = meal.name;
    
    return cell;
}

// PRAGMA MARK: NSFetchResultsDelegate methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
