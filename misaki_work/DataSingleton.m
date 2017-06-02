//
//  NSObject+dataSingleton.m
//  misaki_work
//
//  Created by 早川拓人 on 2017/06/02.
//  Copyright © 2017年 takuto. All rights reserved.
//

#import "DataSingleton.h"

@implementation DataSingleton

static DataSingleton *_sharedData = nil;

+ (DataSingleton *)sharedManager
{
    @synchronized (self) {
        if (!_sharedData) {
            _sharedData = [DataSingleton new];
        }
    }
    return _sharedData;
}

- (id)init
{
    self = [super init];
    if (self) {
        _userDefault = [NSUserDefaults standardUserDefaults];
        NSDictionary *defaultDic = [_userDefault dictionaryForKey:@"categories"];
        self.categories = [[NSMutableDictionary alloc] initWithDictionary:defaultDic];
    }
    return self;
}

#pragma mark -
#pragma mark Category

- (NSDictionary *)getCategories
{
    return self.categories;
}

- (BOOL)saveCategoriesObject:(id)object forKey:(NSString *)key
{
    if (key.length == 0 || key == nil) {
        key = 0;
    }
    [self.categories setObject:object forKey:key];
    [_userDefault setValue:self.categories forKey:@"categories"];
    return [_userDefault synchronize];
}

- (BOOL)removeCategory:(NSString *)category;
{
    [self.categories removeObjectForKey:category];
    [_userDefault setObject:_categories forKey:@"categories"];
    return [_userDefault synchronize];
}

#pragma mark -
#pragma mark Goods

- (NSArray *)getGoodsNumbersCategory:(NSString *)category
{
    return [_userDefault arrayForKey:category];
}

- (NSArray *)getAllCategoryGoods
{
    NSMutableArray *allGoods = [[NSMutableArray alloc] init];
    for (NSString *category in _categories.allKeys) {
        NSArray *goods = [_userDefault objectForKey:category];
        for (NSString *str in goods) {
            [allGoods addObject:[NSString stringWithFormat:@"%@-%@", str, category]];
        }
    }
    return allGoods;
}

- (BOOL)addGoodsNumber:(NSString *)number category:(NSString *)category
{
    NSArray *goodsArray = [_userDefault valueForKey:category];
    NSMutableArray *saveArray = [[NSMutableArray alloc] initWithArray:goodsArray];
    [saveArray addObject:number];
    [_userDefault setValue:saveArray forKey:category];
    return [_userDefault synchronize];
}

- (BOOL)removeCategories
{
    for (NSString *category in _categories) {
        [_userDefault removeObjectForKey:category];
    }
    return [_userDefault synchronize];
}

- (BOOL)removeGoodsNumber:(NSString *)number category:(NSString *)category
{
    NSArray *goodsArray = [_userDefault valueForKey:category];
    NSMutableArray *tmp = [[NSMutableArray alloc] initWithArray:goodsArray];
    int i = 0;
    for (NSString *num in goodsArray) {
        if (number == num) {
            [tmp removeObjectAtIndex:i];
            [_userDefault setValue:tmp forKey:category];
            break;
        }
        i++;
    }
    return [_userDefault synchronize];
}

@end
