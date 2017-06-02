//
//  NSObject+dataSingleton.h
//  misaki_work
//
//  Created by 早川拓人 on 2017/06/02.
//  Copyright © 2017年 takuto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSingleton : NSObject
{
    NSUserDefaults *_userDefault;
}
+ (DataSingleton *)sharedManager;
@property NSMutableArray *goodsNumbers;
@property NSMutableDictionary *categories;

- (NSDictionary *)getCategories;
- (BOOL)removeCategories;
- (BOOL)removeCategory:(NSString *)category;
- (BOOL)saveCategoriesObject:(id)object forKey:(NSString *)key;

- (NSArray *)getGoodsNumbersCategory:(NSString *)category;

- (BOOL)addGoodsNumber:(NSString *)number category:(NSString *)category;
@end
