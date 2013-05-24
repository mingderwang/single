//
//  MDAppDelegate.m
//  single
//
//  Created by Wang Ming-der on 5/11/13.
//  Copyright (c) 2013 Kat Digital Corp. All rights reserved.
//

#import "MDAppDelegate.h"
#import <PXAPI/PXAPI.h>

#define kUserNameForAuthentication  @"mingderwang"
#define kPasswordForAuthentication  @"didipan500"

#define kPXAPIConsumerKey       @"7UTN19sJ3k1XVrPTiTXaXTJJKH6qyshb3TyRhDu2"
#define kPXAPIConsumerSecret    @"wZHbWGA0R5MFkAGlc3eMfLeH8Jx7iuEuKzxZcECu"

@interface MDAppDelegate (PrivateCoreDataStack)
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation MDAppDelegate
@synthesize itemsArray;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Example" inManagedObjectContext:self.managedObjectContext];
	[fetchRequest setEntity:entity];
	
	NSError *error;
	NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // 500px data
    self.itemsArray = [NSMutableArray new];
    [PXRequest setConsumerKey:kPXAPIConsumerKey consumerSecret:kPXAPIConsumerSecret];
    
    PXAPIHelper *helper = [[PXAPIHelper alloc] initWithHost:nil
                                                consumerKey:kPXAPIConsumerKey
                                             consumerSecret:kPXAPIConsumerSecret];
    
    NSDictionary *dictionary = [self jsonDictionaryForRequest:[helper urlRequestForSearchTerm:@"taipei"] expectingResponseCode:200];
    
#ifdef DEBUG
    //    NSLog(@"%s|%@",__PRETTY_FUNCTION__,[dictionary objectForKey:@"photos"]);
#endif
    NSArray *items = [dictionary objectForKey:@"photos"];
    self.itemsArray = [NSMutableArray new];
    for (NSDictionary *item in items) {
        
#ifdef DEBUG
//        NSLog(@"%s|%@",__PRETTY_FUNCTION__,[item objectForKey:@"image_url"][0]);
#endif
        [self.itemsArray addObject:[item objectForKey:@"image_url"][0]];
    }
	
//	self.itemsArray = [[NSMutableArray alloc] initWithArray:results];
//    if ([self.itemsArray count] == 0) {
//        [self initMockData];
//    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"CoreDataExample.sqlite"]];
	
	NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }
	
    return persistentStoreCoordinator;
}


#pragma mark - Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark - core data internal function

- (void) saveContext {
    NSError *error = nil;
    if(self.managedObjectContext != nil) {
        if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
            // Code to handle the error
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
}

- (void) initMockData {
    for (int i= 0; i < 10; i++) {
        [self.itemsArray addObject:[self getItem:i]];
    }
    [self saveContext];
}

- (Example *) getItem: (int) i {
    Example *ex = (Example *)[NSEntityDescription insertNewObjectForEntityForName:@"Example" inManagedObjectContext:managedObjectContext];
	
	NSNumber *digits =[NSNumber numberWithInt:i];
    
	ex.digits = digits;
	ex.item = [NSString stringWithFormat:@"item %d",i];
    return ex;
}

// for 500px
-(NSDictionary *)jsonDictionaryForRequest:(NSURLRequest *)urlRequest expectingResponseCode:(NSInteger)httpResponseCode
{
    NSHTTPURLResponse *returnResponse;
    NSError *connectionError;
    NSData *returnedData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&returnResponse error:&connectionError];
    
    if (connectionError)
    {
        NSLog(@"Connection returned error: %@", connectionError);
        return nil;
    }
    
    if (returnResponse.statusCode != httpResponseCode)
    {
        NSLog(@"Connection returned response code %d but we were expecting %d", returnResponse.statusCode, httpResponseCode);
        return nil;
    }
    
    NSError *jsonParseError;
    NSDictionary *returnedDictionary = [NSJSONSerialization JSONObjectWithData:returnedData options:0 error:&jsonParseError];
    
    return returnedDictionary;
}

@end
