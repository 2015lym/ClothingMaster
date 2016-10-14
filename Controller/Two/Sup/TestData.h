//
//  TestData.h
//  ClothingMaster
//
//  Created by Lym on 16/4/18.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestData : NSObject
@property(nonatomic,strong,readonly)NSArray *TestListArray;
@property(nonatomic,strong,readonly)NSArray *TestDataArray;
-(NSString *)getData:(NSString *)DesignName;
@end
