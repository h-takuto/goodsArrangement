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

- (NSDictionary *)getCategories
{
    return self.categories;
}

- (NSArray *)getGoodsNumbersCategory:(NSString *)category
{
    return [_userDefault arrayForKey:category];
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

- (BOOL)removeCategories
{
    [self.categories removeAllObjects];
    [_userDefault removeObjectForKey:@"categories"];
    return [_userDefault synchronize];
}

- (BOOL)removeCategory:(NSString *)category;
{
    [self.categories removeObjectForKey:category];
    [_userDefault setObject:_categories forKey:@"categories"];
    return [_userDefault synchronize];
}

@end
