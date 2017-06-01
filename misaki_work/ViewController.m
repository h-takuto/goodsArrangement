//
//  ViewController.m
//  misaki_work
//
//  Created by 早川拓人 on 2017/06/01.
//  Copyright © 2017年 takuto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSUserDefaults *_userDefault;
    NSMutableArray *_goodsNumber;
    NSMutableArray *_category;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *categoryArray = [_userDefault arrayForKey:@"category"];
    NSArray *goodsArray;
    if (categoryArray != nil) {
        _category = [[NSMutableArray alloc] initWithArray:categoryArray];
        goodsArray = [_userDefault arrayForKey:[_category objectAtIndex:0]];
        if (goodsArray != nil) {
            _goodsNumber = [[NSMutableArray alloc] initWithArray:goodsArray];
        } else {
            _goodsNumber = [[NSMutableArray alloc] init];
        }
    } else {
        _category = [[NSMutableArray alloc] init];
        _goodsNumber = [[NSMutableArray alloc] init];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addGoods:(id)sender
{
    NSString *num = self.goodsNumberField.text;
    [_goodsNumber addObject:num];
    [_userDefault setObject:_goodsNumber forKey:[_category objectAtIndex:0]];
    [_userDefault synchronize];
}

- (IBAction)addCategory:(id)sender
{
    [_category addObject:self.categoryField.text];
    [_userDefault setObject:_category forKey:@"category"];
    [_userDefault synchronize];
}

- (IBAction)removeData:(id)sender
{
    [_userDefault removeObjectForKey:@"category"];
    [_userDefault removeObjectForKey:[_category objectAtIndex:0]];
}

@end
