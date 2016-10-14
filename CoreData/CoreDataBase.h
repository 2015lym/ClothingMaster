//
//  CoreDataBase.h
//  ClothingMaster
//
//  Created by Lym on 16/4/6.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface CoreDataBase : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(id)shardCoreDataBase;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
@end
