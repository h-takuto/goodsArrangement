//
//  UITableViewController+GoodsViewController.m
//  misaki_work
//
//  Created by 早川拓人 on 2017/06/01.
//  Copyright © 2017年 takuto. All rights reserved.
//

#import "GoodsViewController.h"
#import "DataSingleton.h"

@implementation GoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categoryLabel.text = self.category;
    [DataSingleton sharedManager];
}

- (IBAction)addNumber:(id)sender {
    if ([[DataSingleton sharedManager] addGoodsNumber:self.goodsNumberField.text category:self.category]) {
        NSLog(@"ok");
    }
    
    [self.goodsTableView reloadData];
    self.goodsNumberField.text = @"";
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^(void) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[DataSingleton sharedManager] getGoodsNumbersCategory:self.category].count;
//    return [[DataSingleton sharedManager] getCategories].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
//    NSArray *goods = [[DataSingleton sharedManager] getCategories].allKeys;
    NSArray *goods = [[DataSingleton sharedManager] getGoodsNumbersCategory:self.category];
    cell.textLabel.text = [goods objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
