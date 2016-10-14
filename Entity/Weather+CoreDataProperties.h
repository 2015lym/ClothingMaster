//
//  Weather+CoreDataProperties.h
//  
//
//  Created by Lym on 16/4/12.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Weather.h"

NS_ASSUME_NONNULL_BEGIN

@interface Weather (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *date;
@property (nullable, nonatomic, retain) NSString *lasttime;
@property (nullable, nonatomic, retain) NSString *weatheradv;
@property (nullable, nonatomic, retain) NSString *weatherdata;

@end

NS_ASSUME_NONNULL_END
