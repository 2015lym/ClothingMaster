//
//  CoreDataBase+Query.h
//  ClothingMaster
//
//  Created by Lym on 16/4/6.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import "CoreDataBase.h"

@interface CoreDataBase (Query)

-(NSMutableArray*)queryEntityName:(NSString*)name Where:(NSString*)where;

@end
