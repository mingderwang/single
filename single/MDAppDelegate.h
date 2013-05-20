//
//  MDAppDelegate.h
//  single
//
//  Created by Wang Ming-der on 5/11/13.
//  Copyright (c) 2013 Kat Digital Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Example.h"

@interface MDAppDelegate : UIResponder <UIApplicationDelegate> {
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    
	NSMutableArray *itemsArray;
}
@property (nonatomic, retain) NSMutableArray *itemsArray;
@property (strong, nonatomic) UIWindow *window;

@end
