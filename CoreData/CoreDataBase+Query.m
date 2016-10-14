//
//  CoreDataBase+Query.m
//  ClothingMaster
//
//  Created by Lym on 16/4/6.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import "CoreDataBase+Query.h"

@implementation CoreDataBase (Query)

-(NSMutableArray*)queryEntityName:(NSString*)name Where:(NSString*)where{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:name inManagedObjectContext:self.managedObjectContext];
    if (where != nil) {
        request.predicate = [NSPredicate predicateWithFormat:where];
    }
    request.entity = entity;
    return [[self.managedObjectContext executeFetchRequest:request error:nil] mutableCopy];
}

@end
