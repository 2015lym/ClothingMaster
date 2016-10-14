//
//  DesignData.h
//  ClothingMaster
//
//  Created by Lym on 16/4/14.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DesignData : NSObject
@property(nonatomic,strong,readonly)NSArray *DesignListArray;
@property(nonatomic,strong,readonly)NSArray *DesignDataArray;
-(NSString *)getData:(NSString *)DesignName;
@end
